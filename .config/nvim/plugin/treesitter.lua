local add = require('vim-pack').add
local on_plugin_update = require('vim-pack').on_plugin_update

local parsers = {
  "bash",
  "css",
  "gitcommit",
  "go",
  "graphql",
  "html",
  "java",
  "javascript",
  "json",
  "json5",
  -- "latex",
  "lua",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "rust",
  "tsx",
  "typescript",
  "scss",
  "vim",
  "vimdoc",
  "yaml"
}

add {
  {
    src = 'nvim-treesitter/nvim-treesitter',
    on_setup = function()
      -- Main-branch nvim-treesitter ships queries under `runtime/queries/`,
      -- which isn't on rtp by default. Prepend it so highlights/folds/indents
      -- are visible to `vim.treesitter.start`.
      local init = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/init.lua', false)[1]
      if init then
        vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ':h:h:h') .. '/runtime')
      end

      require('nvim-treesitter').install(parsers):wait(300000)
    end,
  },

  {
    src = 'nvim-treesitter/nvim-treesitter-context',
    module_name = 'treesitter-context',
    opts = {
      -- Avoid the sticky context from growing a lot.
      max_lines = 3,
      -- Match the context lines to the source code.
      multiline_threshold = 1,
      -- Disable it when the window is too small.
      min_window_height = 20,
    },
    on_setup = function()
      vim.keymap.set('n', '<leader>tx', function()
        require("treesitter-context").toggle()
      end, { desc = 'Treesitter Context' })

      vim.keymap.set('n', '[c', function()
        -- Jump to previous change when in diffview.
        if vim.wo.diff then
          return '[c'
        else
          vim.schedule(function()
            require('treesitter-context').go_to_context()
          end)
          return '<Ignore>'
        end
      end, { desc = 'Jump to upper context', expr = true })
    end,
  },

  {
    src = "Wansmer/treesj",
    dependencies = "nvim-treesitter",
    opts = {
      use_default_keymaps = false,
      max_join_length = 999,
    },
    on_setup = function(_)
      vim.keymap.set('n', "<leader>lj", "<cmd>TSJToggle<cr>", { desc = 'Join/split code block' })
    end
  },

  {
    src = "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante", "copilot-chat" },
      bullet = {
        icons = { "•", "◦", "▪", "▫" },
        -- right_pad = 1,
      },
      latex = { enabled = false },
    },
  }
}

on_plugin_update('nvim-treesitter', function()
  -- Re-install (picks up any newly-added parsers from the list above)
  -- and update existing ones.
  require('nvim-treesitter').install(parsers):wait(300000)
  require('nvim-treesitter').update():wait(300000)
end)
