-- Based on https://github.com/MariaSolOs/dotfiles/blob/4ee9f0a4ced7a3c6c00063780eda25b85c9067e1/.config/nvim/lua/lsp.lua

local diagnostic_icons = require('icons').diagnostics

local M = {}

-- Disable inlay hints initially (and enable if needed with the ToggleInlayHints command).
vim.g.inlay_hints = false

---@param client vim.lsp.Client
---@param method string
local function has(client, method)
  method = method:find("/") and method or "textDocument/" .. method
  if client:supports_method(method) then
    return true
  end
  return false
end

---@param client vim.lsp.Client
--- ---@param bufnr integer
local function lsp_keymaps(client, bufnr)
  local snacks = require("snacks")
  local opts = { noremap = true, silent = true, buffer = bufnr }

  local keys = {
    {"[d", function()
      vim.diagnostic.jump { count = -1, float = true }
    end, desc = "Previous diagnostic" },
    {"]d", function()
      vim.diagnostic.jump { count = 1, float = true }
    end, desc = "Next diagnostic" },
    {"[e", function()
      vim.diagnostic.jump { count = -1, float = true, severity = vim.diagnostic.severity.ERROR }
    end, desc = "Previous error" },
    {"]e", function()
      vim.diagnostic.jump { count = 1, float = true, severity = vim.diagnostic.severity.ERROR }
    end, desc = "Next error" },

    -- { "K", vim.lsp.buf.hover, desc = "Hover" },
    -- { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-p>", function()
        -- Close the completion menu first (if open).
        if require('blink.cmp.completion.windows.menu').win:is_open() then
            require('blink.cmp').hide()
        end

        vim.lsp.buf.signature_help()
    end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    -- { "gd", vim.lsp.buf.definition, desc = "Go to definition" },


    { "<leader>lp", function()
      require("utils").lazy_require("peek").peek_definition()
    end, desc = "Peek Definition", has = "definition" },

    { "<leader>ld", function() snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
    { "<leader>lD", function() snacks.picker.lsp_declarations() end, desc = "Goto Declaration", has = "declaration" },
    { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" },
    { "<leader>lK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<leader>ln", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>lr", function() snacks.picker.lsp_references() end, desc = "References", has = "references" },
    { "<leader>ls", function() snacks.picker.lsp_symbols() end, desc = "Buffer Symbols", has = "documentSymbol" },

    { "<leader>lI", function()
      snacks.picker.lsp_implementations()
    end, desc = "Goto Implementation", has = "documentSymbol" },

    { "<leader>ly", function()
      snacks.picker.lsp_type_definitions()
    end, desc = "Goto T[y]pe Definition", has = "documentSymbol" },

    { "<leader>lx", vim.diagnostic.open_float, desc = "Line Diagnostic popup" },
    -- { "<leader>lf", vim.lsp.buf.format, desc = "Format" },
    { "<leader>la", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "Code Actions", has = "codeAction" },
    { "<leader>ll", vim.lsp.codelens.run, mode = { "n", "v" }, desc = "Run Codelens", has = "codeLens" },
    { "<leader>lL", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", has = "codeLens" },
    { "<leader>lC", vim.lsp.document_color.color_presentation, mode = { 'n', 'x' },
      desc = "Color presentation", has = "documentColor"},

    { "<leader>tf", "<cmd>ToggleFormat<cr>", desc = "Auto-format" },
    { "<leader>th", "<cmd>ToggleInlayHints<cr>", desc = "Inlay hints", has = "inlayHint" },
    { "<leader>td", function()
      local new_config = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({ virtual_lines = new_config })
    end, desc = "Diagnostic virtual lines",
    },
  }

  for _, key in pairs(keys) do
    opts.desc = key.desc
    local mode = key.mode or "n"
    if not key.has or has(client, key.has) then
      vim.keymap.set(mode, key[1], key[2], opts)
    end
  end
end

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    -- disable client specific features, e.g. to use null-ls formating instead
    -- local clientsNoFormat = { "ts_ls", "gopls", "lua_ls", "sqlls" }
    -- for _, v in ipairs(clientsNoFormat) do
    --   if client.name == v then
    --     client.server_capabilities.documentFormattingProvider = false
    --   end
    -- end

    -- local clientsNoHover = { "cssmodules_ls", "ruff" }
    -- for _, v in ipairs(clientsNoHover) do
    --   if client.name == v then
    --     client.server_capabilities.hoverProvider = false
    --   end
    -- end

    -- client.server_capabilities.semanticTokensProvider = nil

    if has(client, 'codeAction') then
        require('lightbulb').attach_lightbulb(bufnr, client)
    end

    -- Don't check for the capability here to allow dynamic registration of the request.
    vim.lsp.document_color.enable(true, bufnr, {style = 'virtual'})

    lsp_keymaps(client, bufnr)

    if client:supports_method 'textDocument/documentHighlight' then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('nbl/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client:supports_method 'textDocument/inlayHint' then
        local inlay_hints_group = vim.api.nvim_create_augroup('nbl/toggle_inlay_hints', { clear = false })

        if vim.g.inlay_hints then
            -- Initial inlay hint display.
            -- Idk why but without the delay inlay hints aren't displayed at the very start.
            vim.defer_fn(function()
                local mode = vim.api.nvim_get_mode().mode
                vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
            end, 500)
        end

        vim.api.nvim_create_autocmd('InsertEnter', {
            group = inlay_hints_group,
            desc = 'Enable inlay hints',
            buffer = bufnr,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                end
            end,
        })

        vim.api.nvim_create_autocmd('InsertLeave', {
            group = inlay_hints_group,
            desc = 'Disable inlay hints',
            buffer = bufnr,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end,
        })

        -- Refresh inlay hints when file is changed externally or LSP reattaches
        vim.api.nvim_create_autocmd({ "FileChangedShellPost", "BufReadPost", "LspAttach" }, {
          group = inlay_hints_group,
          desc = "Refresh inlay hints after external changes or LSP reattach",
          buffer = bufnr,
          callback = function()
            -- Check if we still have LSP clients and inlay hints are enabled
            local clients = vim.lsp.get_clients({ bufnr = bufnr })
            if #clients > 0 and vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
              -- Force refresh by toggling
              vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end,
        })
    end

    -- Add "Fix all" command for linters.
    if client.name == 'eslint' or client.name == 'stylelint_lsp' then
        vim.keymap.set('n', '<leader>lA', function()
            if not client then
                return
            end

            client:request('workspace/executeCommand', {
                command = client.name == 'eslint' and 'eslint.applyAllFixes' or 'stylelint.applyAutoFixes',
                arguments = {
                    {
                        uri = vim.uri_from_bufnr(bufnr),
                        version = vim.lsp.util.buf_versions[bufnr],
                    },
                },
            }, nil, bufnr)
        end, {
            desc = string.format('Fix all %s errors', client.name == 'eslint' and 'ESLint' or 'Stylelint'),
            buffer = bufnr,
        })
    end
end

-- Define the diagnostic signs.
for severity, icon in pairs(diagnostic_icons) do
    local hl = 'DiagnosticSign' .. severity:sub(1, 1) .. severity:sub(2):lower()
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Diagnostic configuration.
vim.diagnostic.config {
    update_in_insert = false,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
        },
        numhl = {
          [vim.diagnostic.severity.WARN] = "WarningMsg",
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
    },
    virtual_lines = false,
    -- virtual_lines = { current_line = true },
    virtual_text = {
        prefix = "",
        spacing = 2,
        format = function(diagnostic)
            -- Use shorter, nicer names for some sources:
            local special_sources = {
                ['Lua Diagnostics.'] = 'lua',
                ['Lua Syntax Check.'] = 'lua',
            }

            local message = diagnostic_icons[vim.diagnostic.severity[diagnostic.severity]]
            if diagnostic.source then
                message = string.format('%s %s', message, special_sources[diagnostic.source] or diagnostic.source)
            end
            if diagnostic.code then
                message = string.format('%s[%s]', message, diagnostic.code)
            end

            return message .. ' '
        end,
    },
    float = {
        border = "rounded",
        source = 'if_many',
        -- Show severity icons as prefixes.
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', diagnostic_icons[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        end,
    },
}

-- Override the virtual text diagnostic handler so that the most severe diagnostic is shown first.
local show_handler = assert(vim.diagnostic.handlers.virtual_text.show)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
    show = function(ns, bufnr, diagnostics, opts)
        table.sort(diagnostics, function(diag1, diag2)
            return diag1.severity > diag2.severity
        end)
        return show_handler(ns, bufnr, diagnostics, opts)
    end,
    hide = hide_handler,
}

-- If not using noice.nvim, configure hover and signatureHelp
if not package.loaded["noice"] then
  local hover = vim.lsp.buf.hover
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.buf.hover = function()
      return hover {
          border = "rounded",
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.4),
      }
  end

  local signature_help = vim.lsp.buf.signature_help
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.buf.signature_help = function()
      return signature_help {
          border = "rounded",
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.4),
      }
  end
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers['client/registerCapability']
vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I don't think this can happen but it's a wild world out there.
        if not client then
            return
        end

        on_attach(client, args.buf)
        require("mini.clue").ensure_buf_triggers(args.buf)
    end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        -- Extend neovim's client capabilities with the completion ones.
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)

        -- TODO: Do I need the following two?
        -- capabilities.textDocument.foldingRange = {
        --   dynamicRegistration = false,
        --   lineFoldingOnly = true,
        -- }

        -- capabilities.workspace = {
        --   didChangeWatchedFiles = {
        --     dynamicRegistration = true,
        --   },
        -- }

        vim.lsp.config('*', { capabilities = capabilities })

        local servers = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()
        vim.lsp.enable(servers)
    end,
})

-- HACK: Override buf_request to ignore notifications from LSP servers that don't implement a method.
-- local buf_request = vim.lsp.buf_request
-- ---@diagnostic disable-next-line: duplicate-set-field
-- vim.lsp.buf_request = function(bufnr, method, params, handler)
--     return buf_request(bufnr, method, params, handler, function() end)
-- end

return M
