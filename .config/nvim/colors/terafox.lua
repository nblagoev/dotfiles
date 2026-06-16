local add = require('vim-pack').add

add {
  {
    src = "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
        },
      },
      groups = {
        all = {
          TreesitterContext = { fg = "fg1", bg = "none" },
          TreesitterContextLineNumber = { fg = "fg3", bg = "none" },
          TreesitterContextBottom = { style = "underline", sp = "bg4" },
          NoiceCmdlinePopUp = { bg = "bg0" },
          BlinkCmpKindText = { link = "Operator" },
          BlinkCmpKindFile = { link = "Operator" },
          BlinkCmpKindFolder = { link = "Operator" },
          -- Dap UI.
          DapStoppedLine = { bg = "bg3" },
          NvimDapVirtualText = { style = "underline,italic", fg = "palette.comment" },
        },
      },
    },
  }
}

require('nightfox.config').set_fox('terafox')
require('nightfox').load()


-- -- terafox
-- -- stylua: ignore
-- local palette = {
--   black   = Shade.new("#2F3239", "#4e5157", "#282a30"),
--   red     = Shade.new("#e85c51", "#eb746b", "#c54e45"),
--   green   = Shade.new("#7aa4a1", "#8eb2af", "#688b89"),
--   yellow  = Shade.new("#fda47f", "#fdb292", "#d78b6c"),
--   blue    = Shade.new("#5a93aa", "#73a3b7", "#4d7d90"),
--   magenta = Shade.new("#ad5c7c", "#b97490", "#934e69"),
--   cyan    = Shade.new("#a1cdd8", "#afd4de", "#89aeb8"),
--   white   = Shade.new("#ebebeb", "#eeeeee", "#c8c8c8"),
--   orange  = Shade.new("#ff8349", "#ff9664", "#d96f3e"),
--   pink    = Shade.new("#cb7985", "#d38d97", "#ad6771"),
--
--   comment = "#6d7f8b",
--
--   bg0     = "#0f1c1e", -- Dark bg (status line and float)
--   bg1     = "#152528", -- Default bg
--   bg2     = "#1d3337", -- Lighter bg (colorcolm folds)
--   bg3     = "#254147", -- Lighter bg (cursor line)
--   bg4     = "#2d4f56", -- Conceal, border fg
--
--   fg0     = "#eaeeee", -- Lighter fg
--   fg1     = "#e6eaea", -- Default fg
--   fg2     = "#cbd9d8", -- Darker fg (status line)
--   fg3     = "#587b7b", -- Darker fg (line numbers, fold colums)
--
--   sel0    = "#293e40", -- Popup bg, visual selection bg
--   sel1    = "#425e5e", -- Popup sel bg, search bg
-- }
