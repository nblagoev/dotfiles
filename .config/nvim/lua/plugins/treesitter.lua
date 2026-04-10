return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = 'main',
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      require("ts_context_commentstring").setup({})
      vim.g.skip_ts_context_commentstring_module = true

      -- Make sure that the following are installed:
      require('nvim-treesitter').install {
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
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    -- enabled = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
        max_lines = 3,
        multiline_threshold = 1,
    },
    keys = {
      {
        "<leader>tx",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Treesitter Context",
      },
      {
        "<leader>lc",
        function()
          -- Jump to previous change when in diffview.
          if vim.wo.diff then
              return "<leader>lc"
          else
            vim.schedule(function()
                require("treesitter-context").go_to_context()
            end)
            return "<Ignore>"
          end
        end,
        desc = "Jump to upper context",
        expr = true,
      },
    },
  },

}
