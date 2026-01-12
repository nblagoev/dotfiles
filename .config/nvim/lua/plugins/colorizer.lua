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

return {
  {
    "brenoprata10/nvim-highlight-colors",
    -- enabled = false,
    ft = colored_fts,
    keys = {
      { "<Leader>tc", "<cmd>HighlightColors Toggle<cr>", silent = true, desc = "Colors" },
    },
    opts = {
      render = "virtual",
      virtual_symbol = "󱓻",
    },
  },
}
