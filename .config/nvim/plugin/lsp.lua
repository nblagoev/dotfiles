local add = require('vim-pack').add
local add_on_event = require('vim-pack').add_on_event
local add_on_cmd = require('vim-pack').add_on_cmd
local on_plugin_update = require('vim-pack').on_plugin_update

add_on_cmd('Mason', {
  {
    src = "mason-org/mason.nvim",
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
    on_setup = function(opts)
      local mr = require("mason-registry")
      -- mr:on("package:install:success", function()
      --   vim.defer_fn(function()
      --     -- trigger FileType event to possibly load this newly installed LSP server
      --     require("lazy.core.handler.event").trigger({
      --       event = "FileType",
      --       buf = vim.api.nvim_get_current_buf(),
      --     })
      --   end, 100)
      -- end)
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
})

on_plugin_update('mason.nvim', function()
  vim.cmd("MasonUpdate")
end)

add {
  {
    src = "r4ppz/lspeek.nvim",
  },
  {
    src = "linrongbin16/lsp-progress.nvim",
    disabled = true,
    opts = {
      max_size = 50,
      spinner = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
      -- spinner = { "✶", "✸", "✹", "✺", "✹", "✷" },
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
}

add_on_event({ "BufReadPost", "BufNewFile" }, {
  {
    src = "bassamsdata/namu.nvim",
    opts = {
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
            next = { "<C-n>", "<DOWN>", "<C-j>" },   -- Support multiple keys
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
    },
    on_setup = function(_)
      vim.keymap.set('n', 'gs', function()
        require("namu.namu_symbols").show()
      end, { desc = 'Buffer Symbols' })

      vim.keymap.set('n', 'gS', ':Namu watchtower<cr>', { silent = true, desc = 'Buffer Symbols' })
      vim.keymap.set('n', '<leader>lS', ':Namu workspace<cr>', { silent = true, desc = 'Workspace Symbol' })
      vim.keymap.set('n', '<leader>ld', ':Namu diagnostics<cr>', { silent = true, desc = 'Buffer Diagnostics' })
      vim.keymap.set('n', '<leader>lD', ':Namu diagnostics workspace<cr>',
        { silent = true, desc = 'Workspace Diagnostics' })
    end
  }
})
