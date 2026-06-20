-- Enable the experimental Lua module loader.
vim.loader.enable()

-- Load colorscheme
vim.cmd("colorscheme terafox")

-- Global variables.
vim.g.mapleader = " "
vim.g.maplocalleader = "," -- "\" is the default
vim.g.projects_dir = vim.env.HOME .. '/dev'

-- Define main config table to be able to pass data between scripts
_G.Config = {}

vim.keymap.set("", "<Space>", "<Nop>")

require("mappings")
require("options")
require("commands")
require("autocmds")
require("statusline")
require("marks")
require("lsp")

-- Interactive textual undotree:
-- vim.cmd.packadd 'nvim.undotree'

-- Enable the new experimental command-line features.
-- require('vim._core.ui2').enable {}
