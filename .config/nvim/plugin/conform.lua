local add_on_event = require('vim-pack').add_on_event

add_on_event('BufWritePre', {
  {
    src = 'stevearc/conform.nvim',
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
    on_setup = function()
      vim.keymap.set('n', '<leader>lf', function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = 'Format' })
    end,
  }
})

-- Use conform for gq.
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Start auto-formatting by default (and disable with my ToggleFormat command).
vim.g.autoformat = true
