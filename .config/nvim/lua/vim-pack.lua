-- https://github.com/MariaSolOs/dotfiles/blob/c95753bd88972de283cf497351e9cf90a5c5dc86/.config/nvim/lua/vim-pack.lua
local M = {}

---@class PluginSpec
---@field src string The GitHub repository of the plugin
---@field disabled? boolean Disable the plugin
---@field module_name? string Optional module name for configuration (defaults to the repo name)
---@field opts? table|fun():table Optional configuration options for the plugin
---@field on_setup? fun(table):nil Optional function to run after the plugin is loaded and configured
---@field setup? false Set to false to skip require/setup entirely (for vimscript-only or data-only plugins)

---@param plugins PluginSpec[]
local function configure(plugins)
  local sources = vim.iter(plugins)
      :filter(function(plugin)
        return plugin.disabled ~= true
      end)
      :map(function(plugin)
        -- Ensure we use GitHub urls.
        return string.format('https://github.com/%s', plugin.src)
      end)
      :totable()

  vim.pack.add(sources)

  -- Configure each plugin after loading.
  for _, plugin in ipairs(plugins) do
    if plugin.disabled and plugin.disabled == true then
      goto continue
    end
    local opts = type(plugin.opts) == 'function' and plugin.opts() or plugin.opts
    if plugin.setup ~= false then
      local module_name = plugin.module_name or (plugin.src:match('.+/(.+)'):gsub('%.nvim$', ''))
      local mod = require(module_name)
      if type(mod.setup) == 'function' then
        mod.setup(opts or {})
      end
    end

    if plugin.on_setup then
      plugin.on_setup(opts or {})
    end

    ::continue::
  end
end

---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param pattern? string|string[]
---@param plugins PluginSpec[]
local add_on_event = function(event, pattern, plugins)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    once = true,
    callback = function()
      configure(plugins)
    end,
  })
end

local add_on_cmd = function(cmd, plugins)
  vim.api.nvim_del_user_command(cmd)
  configure(plugins)
end

--- Helper function for adding and configuring plugins eagerly, with no lazy-loading.
---
---@param plugins PluginSpec[]
function M.add(plugins)
  configure(plugins)
end

--- Helper function for adding and configuring plugins to the current session on a specific event.
---
---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param plugins PluginSpec[]
function M.add_on_event(event, plugins)
  add_on_event(event, nil, plugins)
end

function M.add_on_event_pattern(event, pattern, plugins)
  add_on_event(event, pattern, plugins)
end

--- Helper function for adding and configuring plugins to the current session when a file of a specific type is first opened.
---
---@param patterns string|string[]
---@param plugins PluginSpec[]
function M.add_on_file_type(patterns, plugins)
  add_on_event('FileType', patterns, plugins)
end

function M.add_on_cmd(cmd, plugins)
  vim.api.nvim_create_user_command(cmd, function(event)
    local command = {
      cmd = cmd,
      bang = event.bang or nil,
      mods = event.smods,
      args = event.fargs,
      count = event.count >= 0 and event.range == 0 and event.count or nil,
    }

    if event.range == 1 then
      command.range = { event.line1 }
    elseif event.range == 2 then
      command.range = { event.line1, event.line2 }
    end

    add_on_cmd(cmd, plugins)

    local info = vim.api.nvim_get_commands({})[cmd] or vim.api.nvim_buf_get_commands(0, {})[cmd]
    if not info then
      vim.schedule(function()
        Util.error("Command `" .. cmd .. "` not found after loading " .. plugins)
      end)
      return
    end

    command.nargs = info.nargs
    if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then
      command.args = { event.args }
    end
    vim.cmd(command)
  end, {
    bang = true,
    range = true,
    nargs = "*",
    complete = function(_, line)
      add_on_cmd(cmd, plugins)
      -- NOTE: return the newly loaded command completion
      return vim.fn.getcompletion(line, "cmdline")
    end,
  })
end

--- Runs the given command inside the plugin's directory when the plugin is updated.
---
---@param plugin_name string Plugin name
---@param cmd string|fun():nil Command to run
function M.on_plugin_update(plugin_name, cmd)
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
      if args.data.spec.name == plugin_name and (args.data.kind == 'install' or args.data.kind == 'update') then
        if type(cmd) == 'string' then
          vim.system({ cmd }, { cwd = args.data.path })
        else
          cmd()
        end
      end
    end,
  })
end

return M
