local add = require('vim-pack').add
local add_on_file_type = require('vim-pack').add_on_file_type
local add_on_event_pattern = require('vim-pack').add_on_event_pattern

-- Rust
add_on_event_pattern("BufRead", "Cargo.toml", {
  {
    src = "saecki/crates.nvim",
    opts = {},
  },
})

-- Teraform
add_on_file_type('terraform', {
  { src = 'hashivim/vim-terraform' },
})

-- TOML
add {
  { src = 'cespare/vim-toml', setup = false },
}

-- YAML
-- TODO: depends on "nvim-treesitter/nvim-treesitter"
add_on_file_type('yaml', {
  { src = 'cuducos/yaml.nvim' },
})

-- LaTeX
add_on_file_type('tex', {
  { src = "lervag/vimtex" },
})

vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "sioyek" or "zathura"
vim.g.vimtex_compiler_silent = 1
vim.g.vimtex_syntax_enabled = 0
