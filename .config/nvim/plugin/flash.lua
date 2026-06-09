local add_on_event = require('vim-pack').add_on_event

-- Navigation with jump motions.
add_on_event('UIEnter', {
  {
    src = "folke/flash.nvim",
    opts = {},
    on_setup = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'gw', function() require('flash').jump() end, { desc = 'Flash' })
      vim.keymap.set({ 'n', 'x', 'o' }, 'gt', function() require('flash').treesitter_search() end,
        { desc = 'Treesitter Search' })
    end,
  }
})
