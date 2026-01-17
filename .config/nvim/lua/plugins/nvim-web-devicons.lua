return {
  "nvim-tree/nvim-web-devicons",
  enabled = false,
  opts = function()
    return { override = require("icons").devicons_override }
  end,
}
