-- borrowed from https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/plugins/minifiles.lua
local function map_split(buf_id, lhs, direction)
    local minifiles = require 'mini.files'

    local function rhs()
        local window = minifiles.get_explorer_state().target_window

        -- Noop if the explorer isn't open or the cursor is on a directory.
        if window == nil or minifiles.get_fs_entry().fs_type == 'directory' then
            return
        end

        -- Make a new window and set it as target.
        local new_target_window
        vim.api.nvim_win_call(window, function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
        end)

        minifiles.set_target_window(new_target_window)

        -- Go in and close the explorer.
        minifiles.go_in { close_on_file = true }
    end

    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = 'Split ' .. string.sub(direction, 12) })
end

return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.clue",
    version = false,
    event = "VeryLazy",
    opts = function()
      local miniclue = require('mini.clue')

      -- Add a-z/A-Z marks.
      -- https://github.com/MariaSolOs/dotfiles/blob/5d21e802d0e721e6d190dee4c214ec309137a26c/.config/nvim/lua/plugins/miniclue.lua
      local function mark_clues()
          local marks = {}
          vim.list_extend(marks, vim.fn.getmarklist(vim.api.nvim_get_current_buf()))
          vim.list_extend(marks, vim.fn.getmarklist())

          return vim.iter(marks)
              :map(function(mark)
                  local key = mark.mark:sub(2, 2)

                  -- Just look at letter marks.
                  if not string.match(key, '^%a') then
                      return nil
                  end

                  -- For global marks, use the file as a description.
                  -- For local marks, use the line number and content.
                  local desc
                  if mark.file then
                      desc = vim.fn.fnamemodify(mark.file, ':p:~:.')
                  elseif mark.pos[1] and mark.pos[1] ~= 0 then
                      local line_num = mark.pos[2]
                      local lines = vim.fn.getbufline(mark.pos[1], line_num)
                      if lines and lines[1] then
                          desc = string.format('%d: %s', line_num, lines[1]:gsub('^%s*', ''))
                      end
                  end

                  if desc then
                      return { mode = 'n', keys = string.format('`%s', key), desc = desc }
                  end
              end)
              :totable()
      end

      -- Clues for recorded macros.
      local function macro_clues()
          local res = {}
          for _, register in ipairs(vim.split('abcdefghijklmnopqrstuvwxyz', '')) do
              local keys = string.format('"%s', register)
              local ok, desc = pcall(vim.fn.getreg, register)
              if ok and desc ~= '' then
                  ---@cast desc string
                  desc = string.format('register: %s', desc:gsub('%s+', ' '))
                  table.insert(res, { mode = 'n', keys = keys, desc = desc })
                  table.insert(res, { mode = 'v', keys = keys, desc = desc })
              end
          end

          return res
      end

      return {
        triggers = {
          -- Leader triggers
          { mode = { 'n', 'x' }, keys = '<Leader>' },

          -- `[` and `]` keys
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = { 'n', 'x' }, keys = 'g' },

          -- Marks
          { mode = { 'n', 'x' }, keys = "'" },
          { mode = { 'n', 'x' }, keys = '`' },

          -- Registers
          { mode = { 'n', 'x' }, keys = '"' },
          { mode = { 'i', 'c' }, keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` and `,` keys
          { mode = { 'n', 'x' }, keys = 'z' },
          { mode = { 'n', 'x' }, keys = ',' },
        },

        clues = {
          { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
          { mode = 'n', keys = '<Leader>c', desc = '+Code' },
          { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
          { mode = 'n', keys = '<Leader>f', desc = '+File/Fold' },
          { mode = 'n', keys = '<Leader>g', desc = '+Git/Glance' },
          { mode = 'n', keys = '<Leader>h', desc = '+Gitsigns/Harpoon' },
          { mode = 'n', keys = '<Leader>j', desc = '+AI' },
          { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
          { mode = 'n', keys = '<Leader>m', desc = '+Markdown' },
          { mode = 'n', keys = '<Leader>o', desc = '+Open' },
          { mode = 'n', keys = '<Leader>n', desc = '+Notifications' },
          { mode = 'n', keys = '<Leader>p', desc = '+Misc' },
          { mode = 'n', keys = '<Leader>q', desc = '+Quit' },
          { mode = 'n', keys = '<Leader>s', desc = '+Search/Replace' },
          { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
          { mode = 'n', keys = '<Leader>z', desc = '+Zoom' },
          { mode = 'n', keys = '<Leader>/', desc = '+Multicursor' },

          { mode = 'v', keys = '<Leader>c', desc = '+Code' },
          { mode = 'v', keys = '<Leader>d', desc = '+Debug' },
          { mode = 'v', keys = '<Leader>h', desc = '+Gitsigns' },
          { mode = 'v', keys = '<Leader>j', desc = '+AI' },
          { mode = 'v', keys = '<Leader>l', desc = '+LSP' },
          { mode = 'v', keys = '<Leader>o', desc = '+Open' },
          { mode = 'v', keys = '<Leader>s', desc = '+Search/Replace' },

          -- Builtins.
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          -- Custom extras.
          mark_clues,
          macro_clues,
        },

        window = {
          delay = 250,
          config = function(bufnr)
              local max_width = 0
              for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
                  max_width = math.max(max_width, vim.fn.strchars(line))
              end

              -- Keep some right padding.
              max_width = max_width + 2

              return {
                  -- Dynamic width capped at 70.
                  width = math.min(70, max_width),
                  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
              }
          end,
        },
      }
    end,
  },

  {
    "echasnovski/mini.files",
    keys = {
      {
        "-",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ":p")
          if path and vim.uv.fs_stat(path) then
            local MiniFiles = require("mini.files")
            if not MiniFiles.close() then
              MiniFiles.open(bufname, false)
            end
          end
        end,
        silent = true,
        desc = "Mini Files",
      },
    },
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("mini.files").open()
        end
      end
    end,
    opts = function()
      local MiniFiles = require("mini.files")
      local copy_path = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        vim.fn.setreg("+", cur_entry_path)
        print("Path copied to clipboard!")
      end
      local preview_file = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        vim.system({ "qlmanage", "-p", cur_entry_path }, {
          stdout = false,
          stderr = false,
        })
        vim.defer_fn(function()
          vim.system({ "osascript", "-e", 'tell application "qlmanage" to activate' })
        end, 200)
      end
      local make_executable = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        if cur_entry_path and vim.uv.fs_stat(cur_entry_path) then
          local confirm = vim.fn.confirm("Do you want to make this file executable?", "&Yes\n&No", 2)
          if confirm == 1 then
            vim.fn.system({ "chmod", "+x", cur_entry_path })
            print("Changed file mode to executable: " .. cur_entry_path)
          else
            print("Operation cancelled")
          end
        end
      end
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("nbl/mini-files", { clear = true }),
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "Y", copy_path, { buffer = args.data.buf_id, desc = "Copy Path" })
          vim.keymap.set("n", "X", make_executable, { buffer = args.data.buf_id, desc = "Make file executable" })
          if vim.fn.has("mac") == 1 then
            vim.keymap.set("n", "F", preview_file, { buffer = args.data.buf_id, desc = "Preview File in MacOS" })
          end
        end,
      })
      -- HACK: Notify LSPs that a file got renamed or moved.
      -- Borrowed this from snacks.nvim.
      vim.api.nvim_create_autocmd('User', {
          desc = 'Notify LSPs that a file was renamed',
          pattern = { 'MiniFilesActionRename', 'MiniFilesActionMove' },
          callback = function(args)
              local changes = {
                  files = {
                      {
                          oldUri = vim.uri_from_fname(args.data.from),
                          newUri = vim.uri_from_fname(args.data.to),
                      },
                  },
              }
              local will_rename_method, did_rename_method =
                  'workspace/willRenameFiles', 'workspace/didRenameFiles'
              local clients = vim.lsp.get_clients()
              for _, client in ipairs(clients) do
                  if client:supports_method(will_rename_method) then
                      local res = client:request_sync(will_rename_method, changes, 1000, 0)
                      if res and res.result then
                          vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
                      end
                  end
              end

              for _, client in ipairs(clients) do
                  if client:supports_method(did_rename_method) then
                      client:notify(did_rename_method, changes)
                  end
              end
          end,
      })

      vim.api.nvim_create_autocmd('User', {
          desc = 'Add minifiles split keymaps',
          pattern = 'MiniFilesBufferCreate',
          callback = function(args)
              local buf_id = args.data.buf_id
              map_split(buf_id, '<C-w>s', 'belowright horizontal')
              map_split(buf_id, '<C-w>v', 'belowright vertical')
          end,
      })
      return {
        use_as_default_explorer = true,
        mappings = {
          close = "q",
          show_help = "?",
          -- go_in = "<c-l>",
          -- go_out = "<c-h>",
          -- go_in_plus = "<c-l>",
          -- go_in_plus = "l",
          -- go_out_plus = "<tab>",
        },
        windows = { width_nofocus = 25, preview = true, width_preview = 50 },
      }
    end,
  },

  {
    "echasnovski/mini.icons",
    -- enabled = false,
    lazy = true,
    opts = function()
      vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = "#28A2D4" })
      return {
        file = {
          [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
          ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
          README = { glyph = "", hl = "MiniIconsYellow" },
          ["README.md"] = { glyph = "", hl = "MiniIconsYellow" },
          ["README.txt"] = { glyph = "", hl = "MiniIconsYellow" },
        },
        filetype = {
          dotenv = { glyph = "", hl = "MiniIconsYellow" },
          rust = { glyph = "🦀", hl = "MiniIconsOrange" },
        },
        -- extension = {
        --   lua = { glyph = "󰢱", hl = "MiniIconsCyan" },
        -- },
      }
    end,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    {
      "echasnovski/mini.move",
      -- event = "VeryLazy",
      keys = {
        -- { "<M-down>", mode = { "n", "v" } },
        -- { "<M-up>", mode = { "n", "v" } },
        -- { "<M-left>", mode = { "n", "v" } },
        -- { "<M-right>", mode = { "n", "v" } },
        { "<M-j>", mode = { "n", "v" } },
        { "<M-k>", mode = { "n", "v" } },
        { "<M-h>", mode = { "n", "v" } },
        { "<M-l>", mode = { "n", "v" } },
      },
      -- opts = {
      --   mappings = {
      --     -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      --     left = "<M-left>",
      --     right = "<M-right>",
      --     down = "<M-down>",
      --     up = "<M-up>",
      --
      --     -- Move current line in Normal mode
      --     line_left = "<M-left>",
      --     line_right = "<M-right>",
      --     line_down = "<M-down>",
      --     line_up = "<M-up>",
      --   },
      -- },
      config = true,
    },
  },

  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "S", -- Add surrounding
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
        find = "fsr", -- Find surrounding (to the right)
        find_left = "fsl", -- Find surrounding (to the left)
        highlight = "", -- Highlight surrounding
        update_n_lines = "", -- Update `n_lines`
      },
    },
  },

  {
    "echasnovski/mini.tabline",
    version = false,
    cond = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_icons = false,
      format = function(buf_id, label)
        local MiniTabline = require("mini.tabline").default_format(buf_id, label)
        -- local suffix = vim.bo[buf_id].modified and "+ " or "  "
        -- return string.format("  %s%s", MiniTabline, suffix)
        return string.format(" %s ", MiniTabline)
      end,
    },
  },

  {
    "echasnovski/mini.splitjoin",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = {},
  },

  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      draw = {
        delay = 50,
        animation = function()
          return 0
        end,
      },
      symbol = "│",
    },
  },
}
