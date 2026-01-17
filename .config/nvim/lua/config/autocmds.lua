local get_hl_hex = require("utils").get_hl_hex

-- Autocommands
local aucmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("nbl/" .. name, { clear = true })
end

-- Switch theme based on background color
aucmd("OptionSet", {
    pattern = "background",
    callback = function()
        if vim.o.background == "light" then
            vim.cmd("colorscheme dayfox")
        else
            vim.cmd("colorscheme terafox")
        end
    end,
})

-- Prevent accidental writes to buffers that shouldn't be edited
aucmd("BufRead", { pattern = {'*.orig', '*.bak'}, command = 'set readonly' })

-- Autospelling and zen mode for tex and md files
aucmd("BufRead", {
  pattern = { "*.tex", "*.typ", "*.qmd" },
  callback = function()
    vim.cmd("setlocal spell spelllang=en_us")
    -- vim.cmd("ZenMode")
  end,
  group = augroup("tex-md_group"),
})

-- Indent four spaces
aucmd("FileType", {
  pattern = {
    -- "sql",
    "markdown",
  },
  command = "setlocal shiftwidth=4 tabstop=4",
  group = augroup("indent_4"),
})

-- SQL
aucmd("FileType", {
  pattern = { "sql" },
  command = "set nowrap",
  group = augroup("no_wrap"),
})

-- Golang
aucmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tmpl", "*.gohtml" },
  command = "set filetype=html",
  group = augroup("golang"),
})

-- Fix conceallevel for json files
aucmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- format on save for specific files (set in conform config instead)
-- aucmd("BufWritePre", {
--   pattern = { "*.go", "*.lua", "*.rs" },
--   callback = function()
--     -- vim.lsp.buf.format()
--     require("conform").format({ lsp_fallback = true })
--   end,
--   group = augroup("LspFormatting"),
-- })

-- Alpha
aucmd("FileType", {
  group = augroup("Alpha"),
  pattern = { "alpha" },
  -- command = "nnoremap <silent> <buffer> - :bwipe <Bar> Dirvish<CR>",
  callback = function()
    vim.opt_local.fillchars = { eob = " " }
  end,
})

-- go to last loc when opening a buffer
aucmd("BufReadPost", {
  group = augroup("LastLocation"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
aucmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Redraw statusline on different events
aucmd("DiagnosticChanged", {
  group = augroup("Status_Diagnostics"),
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
    vim.cmd("redrawtabline")
  end),
})
aucmd("User", {
  group = augroup("Status_GitUpdate"),
  pattern = "GitSignsUpdate",
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
  end),
})

-- Wrap text for some markdown files and others
aucmd("FileType", {
  group = augroup("md-tex-aucmd"),
  pattern = { "markdown", "tex" },
  callback = function()
    vim.cmd("setlocal wrap")
  end,
})

-- Before saving session with Shatur/neovim-session-manager
aucmd("User", {
  pattern = "SessionSavePre",
  group = augroup("Session"),
  callback = function()
    -- remove buffers whose files are located outside of cwd
    local cwd = vim.fn.getcwd() .. "/"
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local bufpath = vim.api.nvim_buf_get_name(buf) .. "/"
      if not bufpath:match("^" .. vim.pesc(cwd)) then
        vim.api.nvim_buf_delete(buf, {})
      end
    end
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('nbl/dotfiles_setup', { clear = true }),
  desc = 'Special dotfiles setup',
  callback = function()
    local ok, inside_dotfiles = pcall(vim.startswith, vim.fn.getcwd(), vim.env.HOME) --vim.env.XDG_CONFIG_HOME)
    if not ok or not inside_dotfiles then
      return
    end

    local ok, inside_dev = pcall(vim.startswith, vim.fn.getcwd(), vim.env.HOME .. "/dev")
    if not ok or inside_dev then
      return
    end

    -- Configure git environment.
    vim.env.GIT_WORK_TREE = vim.env.HOME
    vim.env.GIT_DIR = vim.env.HOME .. '/.dotfiles'
  end,
})

-- Reset cursor shape on exit (needed in Fish within Tmux somehow)
-- aucmd("VimLeave", {
--   group = augroup("CursorShape"),
--   pattern = "*",
--   callback = function()
--     vim.cmd("set guicursor=a:ver100")
--   end,
-- })

-- Auto-save session on exit
aucmd("VimLeavePre", {
  group = augroup("SessionManagement"),
  callback = function()
    if vim.fn.argc() == 0 then -- Only if no file arguments were passed
      -- Helper function to check if buffer should be included in session
      local function is_valid_session_buffer(buf)
        if not vim.api.nvim_buf_is_loaded(buf) or not vim.bo[buf].buflisted then
          return false
        end

        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buftype = vim.bo[buf].buftype
        local modifiable = vim.bo[buf].modifiable
        local readonly = vim.bo[buf].readonly
        local filetype = vim.bo[buf].filetype

        -- Exclude special buffer types and non-modifiable/readonly buffers
        if buftype ~= "" then
          return false
        end
        if not modifiable or readonly then
          return false
        end

        -- Exclude specific filetypes that shouldn't be in sessions
        if filetype == "netrw" or filetype == "help" or filetype == "qf" then
          return false
        end

        -- Exclude startup buffer and other named special buffers
        if buf_name == "" or buf_name:match("%[.*%]$") then
          return false
        end

        return true
      end

      -- Get all valid file buffers
      local valid_buffers = vim.tbl_filter(is_valid_session_buffer, vim.api.nvim_list_bufs())

      if #valid_buffers > 0 then
        local cwd = vim.fn.getcwd()

        -- Close buffers that are not part of the current working directory
        for _, buf in ipairs(valid_buffers) do
          local buf_name = vim.api.nvim_buf_get_name(buf)
          local buf_dir = vim.fn.fnamemodify(buf_name, ":h")
          if not buf_dir:match("^" .. vim.pesc(cwd)) then
            pcall(vim.api.nvim_buf_delete, buf, { force = false })
          end
        end

        -- Check if there are still valid buffers after CWD filtering
        local remaining_buffers = vim.tbl_filter(is_valid_session_buffer, vim.api.nvim_list_bufs())
        if #remaining_buffers > 0 then
          require("sessions").save_session(nil, false)
        end
      end
    end
  end,
})

-- Convert JSON filetype to JSON with comments (jsonc)
vim.cmd([[
  augroup jsonFtdetect
  autocmd!
  autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  augroup END
]])
