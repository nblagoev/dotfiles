return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format",
    },
  },
  opts = {
    lsp_fallback = true,

    formatters_by_ft = {
      go = { name = 'gopls', timeout_ms = 500, lsp_format = 'prefer' },
      javascript = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
      javascriptreact = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
      json = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
      jsonc = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
      sh = { 'shfmt' },
      typescript = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
      typescriptreact = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
      yaml = { 'prettier' },
      -- For filetypes without a formatter:
      ['_'] = { 'trim_whitespace', 'trim_newlines' },
    },

    format_on_save = function()
      -- Don't format when minifiles is open, since that triggers the "confirm without synchronization" message.
      if vim.g.minifiles_active then
          return nil
      end

      -- Skip formatting if triggered from my special save command.
      if vim.g.skip_formatting then
          vim.g.skip_formatting = false
          return nil
      end

      -- Stop if we disabled auto-formatting.
      if not vim.g.autoformat then
          return nil
      end

      return {}
    end,
  },
  init = function()
      -- Use conform for gq.
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      -- Start auto-formatting by default (and disable with the ToggleFormat command).
      vim.g.autoformat = true
  end,
}
