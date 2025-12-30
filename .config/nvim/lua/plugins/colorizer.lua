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
    "uga-rosa/ccc.nvim",
    -- enabled = false,
    ft = colored_fts,
    cmd = { "CccPick", "CccHighlighterToggle" },
    -- cmd = { "CccPick" },
    keys = {
      -- { ",c", "<cmd>CccHighlighterToggle<cr>", silent = true, desc = "Toggle colorizer" },
      { ",p", "<cmd>CccPick<cr>", silent = true, desc = "Pick color" },
    },
    opts = function()
      local ccc = require("ccc")

      -- Use uppercase for hex codes.
      ccc.output.hex.setup({ uppercase = true })
      ccc.output.hex_short.setup({ uppercase = true })

      return {
        alpha_show = "hide",
        highlighter = {
          -- auto_enable = true,
          auto_enable = false,
          filetypes = colored_fts,
        },
      }
    end,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    -- enabled = false,
    ft = colored_fts,
    keys = {
      { ",c", "<cmd>HighlightColors Toggle<cr>", silent = true, desc = "Toggle colorizer" },
    },
    opts = {
      render = "virtual",
      virtual_symbol = "󱓻",
    },
  },
}
