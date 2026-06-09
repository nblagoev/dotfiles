local add_on_file_type = require('vim-pack').add_on_file_type

local colored_fts = {
  "cfg",
  "css",
  "html",
  "conf",
  "lua",
  "scss",
  "toml",
  "markdown",
  "typescript",
  "typescriptreact",
}

add_on_file_type(colored_fts, {
  {
    src = "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      virtual_symbol = "󱓻",
    },
    on_setup = function(opts)
      vim.keymap.set('n', '<Leader>tc', "<cmd>HighlightColors Toggle<cr>", { silent = true, desc = "Colors" })
    end
  },
})
