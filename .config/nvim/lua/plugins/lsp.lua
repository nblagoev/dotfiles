return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>om", "<cmd>Mason<cr> ", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "basedpyright",
        "bash-language-server",
        "codelldb",
        "flake8",
        "gofumpt",
        "goimports",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "ruff",
        "rust-analyzer",
        "shfmt",
        "sqlfluff",
        "sqlls",
        "stylelint-lsp",
        "stylua",
        "texlab",
        "tinymist",
        "vim-language-server",
        "vtsls",
        "typescript-language-server",
      },
      PATH = "append",
      ui = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "linrongbin16/lsp-progress.nvim",
    opts = {
      max_size = 50,
      spinner = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
      -- client_format = function(client_name, spinner, series_messages)
      client_format = function(_, spinner, series_messages)
        return #series_messages > 0
            -- and (spinner .. " [" .. client_name .. "] " .. table.concat(series_messages, ", "))
            -- and (spinner .. " (LSP) " .. table.concat(series_messages, ", "))
            and (spinner .. " LSP")
          or nil
      end,
      format = function(client_messages)
        if #client_messages > 0 then
          return table.concat(client_messages, " ")
        end
        return ""
      end,
    },
  },

  {
    "bassamsdata/namu.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "gs",
        function()
          require("namu.namu_symbols").show()
        end,
        desc = "Buffer Symbols",
      },
      { "gS", ":Namu watchtower<cr>", silent = true, desc = "Buffer Symbols" },
      { "<leader>lS", ":Namu workspace<cr>", silent = true, desc = "Workspace Symbols" },
      { "<leader>ld", ":Namu diagnostics<cr>", silent = true, desc = "Buffer Diagnostics" },
      { "<leader>lD", ":Namu diagnostics workspace<cr>", silent = true, desc = "Workspace Diagnostics" },
    },
    config = function()
      require("namu").setup({
        namu_symbols = {
          enable = true,
          options = {
            AllowKinds = {
              python = { "Function", "Class", "Method", "Constant", "Variable" },
              lua = { "Function", "Method", "Table", "Module", "Object" },
            },
            display = { format = "tree_guides" },
            preserve_hierarchy = true,
            movement = {
              next = { "<C-n>", "<DOWN>", "<C-j>" }, -- Support multiple keys
              previous = { "<C-p>", "<UP>", "<C-k>" }, -- Support multiple keys
            },
          },
        },
        diagnostics = {
          options = {
            window = {
              min_width = 120,
              max_width = 140,
            },
          },
        },
      })
    end,
  }
}
