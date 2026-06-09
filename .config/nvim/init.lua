-- Enable the experimental Lua module loader.
vim.loader.enable()

-- Load colorscheme
vim.cmd("colorscheme nightfox")

-- Global variables.
vim.g.mapleader = " "
vim.g.maplocalleader = "," -- "\" is the default
vim.g.projects_dir = vim.env.HOME .. '/dev'

vim.keymap.set("", "<Space>", "<Nop>")

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require("mappings")
    require("statusline")
  end,
})

require("options")
require("commands")
require("autocmds")
require("marks")
require("lsp")

-- Interactive textual undotree:
-- vim.cmd.packadd 'nvim.undotree'

-- Enable the new experimental command-line features.
-- require('vim._core.ui2').enable {}
