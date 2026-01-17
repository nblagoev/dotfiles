return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- version = false,
    branch = 'master',
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          scope_incremental = false,
          node_incremental = "<cr>",
          node_decremental = "<bs>",
        },
      },
      ensure_installed = {
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
        "jsonc",
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
      },
      -- autopairs = { enable = true },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      -- context_commentstring = { enable = true, enable_autocmd = false },
      playground = { enabled = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("ts_context_commentstring").setup({})
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    -- enabled = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = function()
      -- make transparent
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "none" })
      return {
        max_lines = 3,
        multiline_threshold = 1,
      }
    end,
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
          vim.schedule(function()
            require("treesitter-context").go_to_context()
          end)
          return "<Ignore>"
        end,
        desc = "Jump to upper context",
        expr = true,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "LspAttach",
    opts = {
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
          },
        },
        lsp_interop = {
          enable = true,
          border = "rounded",
          peek_definition_code = {
            ["<leader>dp"] = "@function.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
