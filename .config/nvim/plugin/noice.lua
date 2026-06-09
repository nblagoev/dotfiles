local add_on_event = require('vim-pack').add_on_event

add_on_event('UIEnter', {
  { src = "MunifTanjim/nui.nvim", setup = false },
  {
    src = "folke/noice.nvim",
    opts = {
      routes = {
        { filter = { event = "msg_show", find = "written" } },
        { filter = { event = "msg_show", find = "yanked" } },
        { filter = { event = "msg_show", find = "%d+L, %d+B" } },
        { filter = { event = "msg_show", find = "; after #%d+" } },
        { filter = { event = "msg_show", find = "; before #%d+" } },
        { filter = { event = "msg_show", find = "%d fewer lines" } },
        { filter = { event = "msg_show", find = "%d more lines" } },
        { filter = { event = "msg_show", find = "<ed" } },
        { filter = { event = "msg_show", find = ">ed" } },
        -- { filter = { event = "notify", find = "position_encoding param is required" } },
        -- { filter = { event = "notify", find = "warning: multiple different client" } },
        { filter = { event = "msg_show", find = "is deprecated" } },
        -- { filter = { warning = true } },
        opts = { skip = true },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true, silent = true },
        signature = { enabled = true },
        progress = { enabled = true },
      },
      cmdline = {
        format = {
          -- input = { view = "cmdline_popup", icon = "󰥻 " },
          -- input = { view = "cmdline_input", icon = "󰥻 " },
          input = { view = "cmdline" },
          cmdline = { icon = "  " },
          search_down = { icon = "   " },
          search_up = { icon = "   " },
          filter = { icon = "  $" },
          lua = { icon = "  " },
          help = { icon = "  " },
        },
      },
      views = {
        cmdline = {
          position = { row = "100%", col = 0 },
          size = { height = "auto", width = "70%" },
        },
        cmdline_input = {
          position = { row = "25%", col = "50%" },
          -- size = { width = "65%" },
          size = { width = "50%" },
        },

        cmdline_popup = {
          position = { row = "100%", col = 0 },
          size = { width = "60%" },
          border = { style = "none", padding = { 0, 0 } },
          -- position = { row = "25%", col = "50%" },
          -- size = { width = "60%" },
        },
      },
      popupmenu = { backend = "cmp" },
      presets = {
        -- bottom_search = true,
        command_palette = true,
        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
    on_setup = function(opts)
      vim.keymap.set('n', '<leader>nl', function() require("noice").cmd("last") end, { desc = 'Noice Last Message' })
      -- vim.keymap.set('n', '<leader>nh', function() require("noice").cmd("history") end, { desc = 'Noice History' })
      vim.keymap.set('n', '<leader>nh', "<cmd>Noice pick<cr>", { desc = 'Noice History"' })
      vim.keymap.set('n', '<leader>nA', function() require("noice").cmd("all") end, { desc = 'Noice All' })
      vim.keymap.set('n', '<leader>nx', function() require("noice").cmd("dismiss") end, { desc = 'Noice Dismiss All' })

      vim.keymap.set('c', '<S-Enter>', function() require("noice").redirect(vim.fn.getcmdline()) end,
        { desc = 'Redirect Cmdline' })

      vim.keymap.set({ "i", "n", "s" }, '<c-f>',
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        { silent = true, expr = true, desc = 'Scroll forward' })
      vim.keymap.set({ "i", "n", "s" }, '<c-b>',
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        { silent = true, expr = true, desc = 'Scroll backward' })
    end,
  }
})
