return {
  "lukas-reineke/virt-column.nvim",
  event = "BufReadPost",
  opts = {
    char = { "│" },
    virtcolumn = "120",
    exclude = { filetypes = { "markdown", "oil" } },
  },
}
