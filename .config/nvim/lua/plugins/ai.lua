return {

  {
    'folke/sidekick.nvim',
    opts = {
      -- Disable next-edit suggestions.
      -- TODO: Give this another chance?
      nes = { enabled = false },
    },
    keys = {
      {
        '<leader>tC',
        function()
          require('sidekick.cli').toggle { name = 'claude', focus = true }
        end,
        desc = 'Claude',
      },
      {
        '<leader>jv',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = 'Send visual selection to Sidekick',
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    keys = {
      {
        "<leader>tP",
        function()
          vim.cmd("Copilot toggle")
        end,
        desc = "Copilot",
      },
    },
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
  },

}
