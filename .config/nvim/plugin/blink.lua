local add = require('vim-pack').add
local on_plugin_update = require('vim-pack').on_plugin_update

-- Auto-completion and snippets.
add {
  { src = 'saghen/blink.lib', setup = false },
  {
    src = 'L3MON4D3/LuaSnip',
    module_name = 'luasnip',
    opts = function()
      local types = require 'luasnip.util.types'
      return {
        -- Check if the current snippet was deleted.
        delete_check_events = 'TextChanged',
        -- Display a cursor-like placeholder in unvisited nodes
        -- of the snippet.
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              virt_text = { { '|', 'Conceal' } },
              virt_text_pos = 'inline',
            },
          },
          [types.exitNode] = {
            unvisited = {
              virt_text = { { '|', 'Conceal' } },
              virt_text_pos = 'inline',
            },
          },
          [types.choiceNode] = {
            active = {
              virt_text = { { '(snippet) choice node', 'LspInlayHint' } },
            },
          },
        },
      }
    end,
    on_setup = function(opts)
      -- Load my custom snippets:
      require('luasnip.loaders.from_vscode').lazy_load {
        paths = vim.fn.stdpath 'config' .. '/snippets',
      }

      vim.keymap.set('i', '<C-r>s', function()
        require('luasnip.extras.otf').on_the_fly 's'
      end, { desc = 'Insert on-the-fly snippet' })

      -- Use <C-c> to select a choice in a snippet.
      vim.keymap.set({ 'i', 's' }, '<C-c>', function()
        ---@diagnostic disable-next-line: undefined-field
        if require('luasnip').choice_active() then
          require 'luasnip.extras.select_choice' ()
        end
      end, { desc = 'Select choice' })
    end,
  },
  {
    src = 'saghen/blink.cmp',
    opts = {
      snippets = {
        preset = "luasnip",
      },
      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false, auto_insert = true } },
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return {}
          elseif type == ":" or type == "@" then
            return { "cmdline", "path" }
          end
          return {}
        end,
      },
      sources = {
        -- default = { "lsp", "path", "snippets", "buffer", "copilot" },
        -- Disable some sources in comments and strings.
        default = function()
          local sources = { 'copilot', 'lsp', 'buffer' }
          local ok, node = pcall(vim.treesitter.get_node)

          if ok and node then
            if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
              table.insert(sources, 'path')
            end
            if node:type() ~= 'string' then
              table.insert(sources, 'snippets')
            end
          end

          return sources
        end,
        -- Make sure file paths don't show up as properties in the cmdline list
        priority = { "path", "cmdline" }, -- <-- Only sources that must be deduplicated
        providers = {
          path = {
            opts = {
              show_hidden_files_by_default = true,
            },
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          lsp = { opts = { tailwind_color_icon = "󱓻" } },
        },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        list = {
          selection = { preselect = true, auto_insert = true },
          max_items = 20,
        },
        menu = {
          border = "rounded",
          draw = {
            gap = 2,
            columns = {
              { 'kind_icon', 'kind',              gap = 1 },
              { 'label',     'label_description', gap = 1 },
            },
          },
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          },
        },
      },
      appearance = {
        kind_icons = require('icons').kind,
      },
      keymap = {
        preset = "enter",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-y>"] = { "select_and_accept" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
    },
    on_setup = function(opts)
      -- https://github.com/saghen/blink.cmp/issues/1222
      local original = require("blink.cmp.completion.list").show
      ---@diagnostic disable-next-line: duplicate-set-field
      require("blink.cmp.completion.list").show = function(ctx, items_by_source)
        local seen = {}
        local function filter(item)
          if seen[item.label] then return false end
          seen[item.label] = true
          return true
        end
        for id in vim.iter(opts.sources.priority) do
          items_by_source[id] = items_by_source[id] and vim.iter(items_by_source[id]):filter(filter):totable()
        end
        return original(ctx, items_by_source)
      end
    end
  },
}

on_plugin_update('blink.cmp', function()
  -- TODO: Fix the Task type below.
  ---@diagnostic disable-next-line: undefined-field
  require('blink.cmp').build():wait(60000)
end)
