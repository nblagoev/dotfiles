-- Inspired by https://github.com/idr4n/nvim-lua/blob/9c36eed2a3b751994c96718136c9165e38387f20/lua/config/statusline/init.lua
-- and https://github.com/mcauley-penney/nvim/blob/d1e11271246b55461a61c9f860e6843ff5a7a438/lua/ui/statusline.lua

local ut = require("utils")
local c = require("statusline.components")
local colors = c.colors

local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
local fg_lighten = normal_hl.bg and ut.darken(string.format("#%06x", normal_hl.bg), 0.6) or colors.stealth

-- Create highlight groups
vim.api.nvim_set_hl(0, "SLBgNoneHl", { fg = colors.fg_hl, bg = "none" })
vim.api.nvim_set_hl(0, "StatusReplace", { bg = colors.red, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { bg = colors.insert, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { bg = colors.select, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { bg = colors.blue, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { bg = colors.yellow, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusReplaceInv", { fg = colors.red, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsertInv", { fg = colors.insert, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisualInv", { fg = colors.select, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormalInv", { fg = colors.blue, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.yellow, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLNotModifiable", { fg = colors.yellow, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormal", { fg = fg_lighten, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#FF7EB6", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLMatches", { fg = colors.bg_hl, bg = colors.fg_hl })
vim.api.nvim_set_hl(0, "SLDecorator", { fg = "#414868", bg = "#7AA2F7", bold = true })

local function is_python()
  return vim.startswith(vim.bo.ft, 'python')
    or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':e') == 'ipynb'
end

---@return string
function Status_line()
  local filetype = vim.bo.filetype
  local components = {
    -- "%#SLNormal#",
    -- c.padding(),
    c.mode(),
    c.fileinfo({ add_icon = true }),
    "%=",
    c.maximized_status(),
    c.show_macro_recording(),
    c.dap() or c.lsp_progress(),
    "%=",
    _G.show_more_info and c.lang_version() or "",
    _G.show_more_info and c.LSP() or "",
    _G.show_more_info and " Ux%04B " or "",
    _G.show_more_info and c.padding(2) or "",
    _G.show_more_info and c.tab_width() or "",
    _G.show_more_info and c.padding(2) or "",
    c.terminal_status(),
    _G.show_more_info and is_python() and c.venv() or "",
    _G.show_more_info and c.git_branch() or "",
    _G.show_more_info and c.separator() or "",
    c.codeium_status(),
    c.get_copilot_status(),
    c.search_count(),
    c.padding(2),
    c.get_fileinfo_widget(),
    c.padding(),
    c.get_position(),
    c.padding(2),
    -- c.file_icon() .. " ",
    filetype:upper(),
    c.padding(2),
    c.scrollbar2(),
    c.padding(),
    c.lsp_diagnostics_simple(),
    c.git_status_simple(),
    -- c.padding(3),
  }

  return table.concat(components)
end

---@return string
function Status_line_inactive()
  local filetype = vim.bo.filetype
  local components = {
    -- "%#SLNormal#",
    -- c.padding(),
    -- c.mode(),
    c.fileinfo({ add_icon = true }),
    "%=",
    c.maximized_status(),
  }

  return table.concat(components)
end

vim.o.statusline = '%!luaeval("Status_line()")'
-- vim.go.statusline = '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.Status_line() : v:lua.Status_line_inactive()%}'
-- vim.o.statusline = "%{%(nvim_get_current_win()==#g:actual_curwin) ? luaeval('Status_line()') : luaeval('Status_line_inactive()')%}"
