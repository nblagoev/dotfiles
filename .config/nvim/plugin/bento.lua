local add_on_event = require('vim-pack').add_on_event

add_on_event('UIEnter', {
  {
    src = "serhez/bento.nvim",
    opts = {
      max_open_buffers = 10,
    }
  }
})
