local add = require('vim-pack').add

add {
  {
    src = "jake-stewart/multicursor.nvim",
    setup = false,
    on_setup = function(opts)
      local mc = require("multicursor-nvim")
      mc.setup()

      -- Add or skip cursor above/below the main cursor.
      vim.keymap.set({ "n", "x" }, '<up>', function() mc.lineAddCursor(-1) end, { desc = 'Multicursor' })
      vim.keymap.set({ "n", "x" }, '<down>', function() mc.lineAddCursor(1) end, { desc = 'Multicursor' })

      vim.keymap.set({ "n", "x" }, '<C-N>', function() mc.matchAddCursor(1) end, { desc = 'Multicursor' })
      vim.keymap.set({ "n", "x" }, '<leader>/n', function() mc.matchAddCursor(1) end,
        { desc = 'Multicursor - Add next match' })
      vim.keymap.set({ "n", "x" }, '<leader>/s', function() mc.matchSkipCursor(1) end,
        { desc = 'Multicursor - Skip match' })

      vim.keymap.set({ "n", "x" }, '<leader>/t', mc.toggleCursor, { desc = 'Multicursor - Toggle' })
      vim.keymap.set({ "n", "x" }, '<leader>/a', mc.duplicateCursors, { desc = 'Multicursor - Add cursor in place' })
      vim.keymap.set("n", '<leader>/v', mc.restoreCursors, { desc = 'Multicursor - Restore cursors' })

      vim.keymap.set({ "x" }, '<leader>/I', mc.insertVisual, { desc = 'Multicursor - Insert for each line' })

      vim.keymap.set("n", '<leader>/A', mc.searchAllAddCursors, { desc = 'Multicursor - Add all cursors on search' })
      vim.keymap.set("n", '<leader>/N', function() mc.searchAddCursor(1) end,
        { desc = 'Multicursor - Search add cursor"' })
      vim.keymap.set("n", '<leader>/S', function() mc.searchSkipCursor(1) end,
        { desc = 'Multicursor - Search skip cursor' })
      vim.keymap.set("n", '<leader>/l', mc.alignCursors, { desc = 'Multicursor - Aligh cursors' })

      vim.keymap.set("x", '<leader>/M', mc.matchCursors, { desc = 'Multicursor - Match by regex' })
      vim.keymap.set("x", '<leader>/P', mc.splitCursors, { desc = 'Multicursor - Split by regex' })

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end,
  }
}
