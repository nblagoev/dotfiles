local add = require('vim-pack').add
local add_on_cmd = require('vim-pack').add_on_cmd

add {
  {
    src = 'folke/sidekick.nvim',
    opts = {
      -- Disable next-edit suggestions.
      -- TODO: Give this another chance?
      nes = { enabled = false },
    },
    on_setup = function(opts)
      vim.keymap.set('n', '<leader>tC', function()
        require('sidekick.cli').toggle { name = 'claude', focus = true }
      end, { desc = 'Claude' })

      vim.keymap.set('x', '<leader>jv', function()
        require('sidekick.cli').send { msg = '{selection}' }
      end, { desc = 'Send visual selection to Sidekick' })
    end
  },
}

add_on_cmd("Copilot", {
  {
    src = "AndreM222/copilot-lualine",
  },

  {
    src = "zbirenbaum/copilot.lua",
    module_name = 'copilot',
    opts = {
      panel = {
        enabled = false, -- replaced by blink-copilot
        auto_refresh = true,
      },
      suggestion = {
        enabled = false, -- replaced by blink-copilot
        auto_trigger = true,
        keymap = {
          accept = "<C-c>",
          accept_word = false,
          accept_line = false,
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-]>",
        },
      },
    },
    on_setup = function(opts)
      vim.keymap.set('n', '<leader>tP', function()
        vim.cmd("Copilot toggle")
      end, { desc = 'Copilot' })
    end,
  },
})
