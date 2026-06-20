-- stylua: ignore start

-- Create global tables with information about clue groups in certain modes
-- Structure of tables is taken to be compatible with 'mini.clue'.
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b',     desc = '+Buffers' },
  { mode = 'n', keys = '<Leader>d',     desc = '+Debug' },
  { mode = 'n', keys = '<Leader>f',     desc = '+File/Fold' },
  { mode = 'n', keys = '<Leader>g',     desc = '+Git/Glance' },
  { mode = 'n', keys = '<Leader>h',     desc = '+Git hunks' },
  { mode = 'n', keys = '<Leader>j',     desc = '+AI' },
  { mode = 'n', keys = '<Leader>l',     desc = '+Language' },
  { mode = 'n', keys = '<Leader>L',     desc = '+Lua' },
  { mode = 'n', keys = '<Leader>n',     desc = '+Notifications' },
  { mode = 'n', keys = '<Leader>o',     desc = '+Open' },
  { mode = 'n', keys = '<Leader>q',     desc = '+Quit' },
  { mode = 'n', keys = '<Leader>s',     desc = '+Search/Replace' },
  { mode = 'n', keys = '<Leader>t',     desc = '+Toggle' },
  { mode = 'n', keys = '<Leader>/',     desc = '+Multicursor' },
  { mode = 'n', keys = '<Leader><Tab>', desc = '+Tabs' },

  { mode = 'v', keys = '<Leader>c',     desc = '+Code' },
  { mode = 'v', keys = '<Leader>d',     desc = '+Debug' },
  { mode = 'v', keys = '<Leader>h',     desc = '+Gitsigns' },
  { mode = 'v', keys = '<Leader>j',     desc = '+AI' },
  { mode = 'v', keys = '<Leader>l',     desc = '+Language' },
  { mode = 'v', keys = '<Leader>o',     desc = '+Open' },
  { mode = 'v', keys = '<Leader>s',     desc = '+Search/Replace' },
}

local map_key = function(modes, keys, rhs, options)
  if type(modes) == "string" then
    modes = vim.split(modes, "", { plain = true, trimempty = false })
  end
  options = options or {}
  if type(options) == "string" then
    options = { desc = options }
  end
  options = vim.tbl_deep_extend("force", { silent = true }, options)
  vim.keymap.set(modes, keys, rhs, options)
end

local map_leader = function(modes, suffix, rhs, opts)
  map_key(modes, '<Leader>' .. suffix, rhs, opts)
end

-- Basic mappings ============================================================

map_key("n", "U", "<C-r>", "Redo")
map_key("n", "J", "mzJ`z", "Join lines and keep cursor position")

-- Add undo break-points
map_key("i", ",",       ",<c-g>u")
map_key("i", ".",       ".<c-g>u")
map_key("i", ";",       ";<c-g>u")
map_key("i", "<Space>", "<Space><c-g>u")

-- Motions
map_key("ic", "jj",   "<ESC>")        -- Press jj/jk fast to return to normal mode
map_key("ic", "jk",   "<ESC>")
map_key("t", "<Esc>", [[<C-\><C-n>]])
map_key("t", "jj",    [[<C-\><C-n>]])
map_key("t", "jk",    [[<C-\><C-n>]])
map_key("n", "j",     "gj")           -- Move up and down with wrapped lines
map_key("n", "k",     "gk")
map_key("n", "<c-d>", "<c-d>zz")      -- Center when scrolling page down and up
map_key("n", "<c-u>", "<c-u>zz")
map_key("n", "n",     "nzzzv")        -- Center around next search result
map_key("n", "N",     "Nzzzv")

-- Helix Motions
map_key("nvo", "gk", "0",  "Go to start of line")
map_key("nvo", "gh", "^",  "Go to beginning of line")
map_key("no",  "gl", "$",  "Go to end of line")
map_key("v", "gl", "$h", "Select to end of line")

-- Move cursor around
map_key("niv", "<C-z>", function() require("utils").CursorMoveAround() end, "Move Around Cursor")

-- Select
local select_outer_node = function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require 'vim.treesitter._select'.select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end
local select_inner_node = function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require 'vim.treesitter._select'.select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end

map_key("n",   ",A", "ggVG<c-$>",         "Select All")
map_key("n",   ",a", "^v$h",              "Select line-no-end")
map_key("n",   "g;", "^v$h",              "Select line-no-end")
map_key("nxo", "<cr>", select_outer_node, "Select parent (outer) node")
map_key("nxo", "<bs>", select_inner_node, 'Select child (inner) node')

-- Search
map_key("n", "*", "*N",                                      "Search exact word (forward)")
map_key("n", "#", "#N",                                      "Search exact word (backward)")
map_key("n", "g*", "g*N",                                    "Search not exact (forward)")
map_key("n", "g#", "g#N",                                    "Search not exact (backward)")
map_key("v", "*", "y/\\V<C-R>=escape(@\",'/')<CR><CR>N",     "Search selection")
map_key("v", "g*", "y/\\V\\C<C-R>=escape(@\",'/')<CR><CR>N", "Search selection (case sensitive)")

-- Edit
local insert_line_below = "<cmd>call append(line('.'),   repeat([''], v:count1))<cr>"
local insert_line_above = "<cmd>call append(line('.')-1, repeat([''], v:count1))<cr>"

map_key("n", "]<space>", insert_line_below,        "Insert line below")
map_key("n", "[<space>", insert_line_above,        "Insert line above")
-- keymap("n", "<A-j>", "<cmd>m .+1<cr>==",        "Move line down")
-- keymap("n", "<A-k>", "<cmd>m .-2<cr>==",        "Move line up")
-- keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move line down")
-- keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move line up")
-- keymap("v", "<A-j>", ":m '>+1<cr>gv=gv",        "Move line down")
-- keymap("v", "<A-k>", ":m '<-2<cr>gv=gv",        "Move line up")

-- Transpose
map_key("n", ",T", '"zx"zph',                   "Transpose/Swap characters")
map_key("n", ",W", '"zdiwxea<space><esc>"zpbb', "Transpose/Swap words")

-- Substitute previously searched word
map_key("v", ",R", ":s///g<LEFT><LEFT>",                                   "Replace search") -- on selection only
map_key("n", ",R", ":%s///g<LEFT><LEFT>",                                  "Replace search") -- on entire buffer
map_key("n", ",X", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Substitute current word")
map_key("v", ",X", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]],            "Substitute selection")

-- Comment
local toggle_line_comment = function()
  local comment_line_current = "<Plug>(comment_toggle_linewise_current)"
  local comment_line_count = "<Plug>(comment_toggle_linewise_count)"
  return vim.v.count == 0 and comment_line_current or comment_line_count
end

map_key("n", "<C-c>", toggle_line_comment,   { expr = true, desc =  "Comment line" })
map_key("n", "<C-b>", "<Plug>(comment_toggle_blockwise_current)",   "Comment block")
map_key("x", "<C-c>", "<Plug>(comment_toggle_linewise_visual)",     "Comment line(s)")
map_key("x", "<C-b>", "<Plug>(comment_toggle_blockwise_visual)",    "Comment block")
map_key("n", "gcy",   "gcc:t.<cr>gcc",       { remap = true, desc = "Duplicate-comment line" })
map_key("v", "gy",    ":t'><cr>gvgcgv<esc>", { remap = true, desc = "Duplicate and comment" })

-- Fold
local close_folds_except_current = function()
  vim.cmd.normal({ "zMzv", bang = true })
end

map_key("n", "z0", ":set foldlevel=0<cr>",                           "Fold level 0")
map_key("n", "z1", ":set foldlevel=1<cr>",                           "Fold level 1")
map_key("n", "z2", ":set foldlevel=2<cr>",                           "Fold level 2")
map_key("n", "z3", ":set foldlevel=3<cr>",                           "Fold level 3")
map_key("n", "z9", ":set foldlevel=99<cr>",                          "Fold level 99")
map_key("n", "zm", ":set foldmethod=marker<cr>:set foldlevel=0<cr>", "Set fold marker")
map_key("nx", "zV", close_folds_except_current,                      "Close all folds except current")

-- Stay in indent mode
map_key("v", "<", "<gv")
map_key("v", ">", ">gv")

-- Replace the easy-clip plugin
map_key("nvo",  ",p",   '"+p', "Paste from clipboard")
map_key("nvo",  ",P",   '"+P', "Paste from clipboard")
map_key("nvo",  ",y",   '"+y', "Yank to clipboard")
map_key("n",    ",Y",   '"+Y', { remap = true, desc = "Yank to clipboard line-end" })
map_key("",     ",m",   '"+d', "Cut to clipboard")
map_key("vx",   "p",    '"_dP')
map_key("nv",   "d",    '"_d')
map_key("n",    "D",    '"_D')
map_key("n",    "gm",   "m",   "Add mark")
map_key("",     "m",    "d")
map_key("",     "M",    "D")
map_key("nv",   "x",    '"_x')
map_key("n",    "X",    '"_X')
map_key("nxov", "c",    '"_c')
map_key("n",    "cc",   '"_cc')
map_key("n",    "cl",   '"_cl')
map_key("n",    "ce",   '"_ce')
map_key("n",    "ci",   '"_ci')
map_key("n",    "C",    '"_C')

-- Windows
map_key("n", "<C-h>",     "<C-w>h")         -- Better window navigation
map_key("n", "<C-j>",     "<C-w>j")
map_key("n", "<C-k>",     "<C-w>k")
map_key("n", "<C-l>",     "<C-w>l")
map_key("n", "<C-Up>",    ":resize -2<CR>") -- Resize windows with arrows
map_key("n", "<C-Down>",  ":resize +2<CR>")
map_key("n", "<C-Left>",  ":vertical resize -2<CR>")
map_key("n", "<C-Right>", ":vertical resize +2<CR>")

-- Maximize window
vim.b.is_zoomed = false
vim.w.original_window_layout = {}

local function toggle_maximize_buffer()
  if not vim.b.is_zoomed then
    -- Save the current window layout
    vim.w.original_window_layout = vim.api.nvim_call_function("winrestcmd", {})
    -- Maximize the current window
    vim.cmd("wincmd _")
    vim.cmd("wincmd |")
    vim.b.is_zoomed = true
  else
    -- Restore the previous window layout
    vim.api.nvim_call_function("execute", { vim.w.original_window_layout })
    vim.b.is_zoomed = false
  end
end
map_key("nt", "<A-,>", toggle_maximize_buffer, "Maximize buffer")

-- Leader mappings ============================================================

-- Buffers
local close_buffer = function()
  if vim.bo.filetype == "gitcommit" then
    vim.cmd("bdelete")
  else
    require("snacks").bufdelete()
  end
end
local close_all_buffers = function()
  require("utils").close_all_bufs({ close_current = false })
end

map_leader("n", "bx", close_buffer,      "Close (delete) Buffer")
map_leader("n", "bd", ":bdelete<CR>",    "Delete Buffer and Window")
map_leader("n", "bD", ":Bdelete!<CR>",   "Force Close Buffer!")
map_leader("n", "bw", ":bwipeout<CR>",   "Wipeout Buffer")
map_leader("n", "bo", close_all_buffers, "Close all buffers")

-- File/Fold
local fold_treesitter = ":set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>"
local function pick_dotfiles()
  local home = os.getenv("HOME")

  Snacks.picker({
    finder = "proc",
    title = "Dotfiles",
    cmd = "/opt/homebrew/bin/git",
    args = {
      "--git-dir=" .. home .. "/.dotfiles/",
      "--work-tree=" .. home,
      "ls-tree",
      "--full-tree",
      "--name-only",
      "-r",
      "HEAD",
    },
    -- This handles the sed logic: prepending $HOME to the git output
    transform = function(item)
      item.file = home .. "/" .. item.text
      return item
    end,
    -- Tells Snacks to show icons and handle file opening
    format = "file",
  })
end

map_leader("n",   "fx", fold_treesitter,              "Set fold treesitter")
map_leader("n",   "fi", ":set foldmethod=indent<cr>", "Set fold indent")
map_leader("n",   "fm", ":set foldmethod=marker<cr>", "Set fold marker")
map_leader("nvo", "fd", pick_dotfiles,                "Dotfiles")

-- Tabs
map_leader("n", "<tab>d", ":tabclose<cr>", "Close tab")
map_leader("n", "<tab>q", ":tabclose<cr>", "Close tab")
map_leader("n", "<tab>l", "<cmd>tablast<cr>", "Last Tab")
map_leader("n", "<tab>f", "<cmd>tabfirst<cr>", "First Tab")
map_leader("n", "<tab><tab>", "<cmd>tabnew<cr>", "New Tab")
map_leader("n", "<tab>]", "<cmd>tabnext<cr>", "Next Tab")
map_leader("n", "<tab>[", "<cmd>tabprevious<cr>", "Previous Tab")

-- Toggle
local toggle_diagnostics = function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

map_leader("n", "tl", "<Cmd>set invrelativenumber<CR>",               "Line Numbers (Relative)")
map_leader("n", "tw", "<Cmd>set wrap!<CR>",                           "Line wrap")
map_leader("n", "tr", "<cmd>nohlsearch|diffupdate|normal! <C-L><CR>", "Redraw / clear hlsearch / diff update")
map_leader("n", "tD", toggle_diagnostics,                             "Diagnostics")

-- Open
map_leader("n", "op", "<cmd>e#<cr>", "Reopen buffer")

-- Quit
map_leader("n", "qq", ":qa<CR>",                        "Quit all")
map_leader("n", "qw", ":q<CR>",                         "Quit window")
map_leader("n", "qQ", ":q!<CR>",                        "Force Quit")
map_leader('n', 'qR', '<cmd>restart<cr>',               "Restart Neovim")
map_leader("n", "qs", require("sessions").load_session, "Session - Load")

-- Misc
local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format(
    [[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
    ftype,
    ftype
  ))
end

map_leader("n", "w", "<cmd>noa w<CR>",                 "Save file, no formatting")
map_leader("n", "P", "<Cmd>lua vim.pack.update()<CR>", "Update packages")
map_leader("x", "D", compare_to_clipboard,             "Compare to clipboard")
