return {
  "serhez/bento.nvim",
  enabled = true,
  event = "VeryLazy",
  config = function()
    require("bento").setup({
      max_open_buffers = 10,
    })
  end,
}
