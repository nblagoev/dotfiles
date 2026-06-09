local add = require('vim-pack').add

add {
  {
    src = 'folke/snacks.nvim',
    opts = function()
      local exclude_pattern = {
        'node_modules',
        '.DS_Store',
        '.next',
        '**/_build/',
        'deps/',
        '**/__pycache__/',
        '.ruff_cache',
        '**/target/',
        '**/assets/node_modules/',
        '**/assets/vendor/',
        '**/build/',
        '**/out/',
        '*.class',
      }
      return {
        image = {
          enabled = false,
          doc = { inline = false },
          math = {
            enabled = false,
            latex = { font_size = 'large' },
          },
        },
        scroll = { enabled = false },
        picker = {
          prompt = '   ',
          ui_select = true,
          sources = {
            files = {
              hidden = true,
              ignored = true,
              exclude = exclude_pattern,
            },
          },
          layout = { layout = { backdrop = false } },
          formatters = {
            file = {
              filename_first = true,
            },
          },
          matcher = { frecency = true },
          win = {
            input = {
              keys = {
                ['<c-l>'] = { 'toggle_preview', mode = { 'i', 'n' } },
                ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                ['l'] = { 'confirm', mode = { 'n' } },
                ['s'] = { 'close', mode = { 'n' } },
                ['<c-\\>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
                ['<c-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
              },
            },
          },
        },
      }
    end,
    on_setup = function(opts)
      local snacks = require('snacks')
      local default_opts =
      { layout = { preset = 'select', layout = { width = 0.6, min_width = 100, height = 0.3, min_height = 17 } } }

      -- stylua: ignore
      local buffers_opts = {
        sort_lastused = false,
        on_show = function() vim.cmd.stopinsert() end,
        layout = { preset = 'select', layout = { width = 0.6, min_width = 90, height = 0.3, min_height = 15 } },
      }

      -- stylua: ignore
      vim.keymap.set('n', '<leader>ff', function() snacks.picker.files() end, { desc = 'Find Files' })
      vim.keymap.set('n', '<C-Space>', function() snacks.picker.files(default_opts) end, { desc = 'Find Files' })
      -- vim.keymap.set('n', 's', function() snacks.picker.buffers(buffers_opts) end, {desc = 'Buffers' })
      vim.keymap.set('n', "<leader>'", function() snacks.picker.resume() end, { desc = 'Resume picker' })
      vim.keymap.set('n', '<leader>u', function() snacks.picker.undo() end, { desc = 'Undo Tree' })
      vim.keymap.set('n', '<leader>e', function() snacks.explorer({ follow_file = true }) end, { desc = 'File Explorer' })
      -- vim.keymap.set('n', '<C-P>', function() snacks.picker() end, {desc = 'Show all pickers' },
      -- find
      vim.keymap.set('n', '<leader>fb', function() snacks.picker.buffers() end, { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fg', function() snacks.picker.git_files() end, { desc = 'Find Git Files' })
      vim.keymap.set('n', '<leader>fr', function() snacks.picker.recent() end, { desc = 'Recent' })
      -- git
      vim.keymap.set('n', '<leader>gc', function() snacks.picker.git_log() end, { desc = 'Git Log' })
      vim.keymap.set('n', '<leader>gs',
        function() snacks.picker.git_status({ on_show = function() vim.cmd.stopinsert() end }) end,
        { desc = 'Git Status' })
      -- Grep
      vim.keymap.set('n', '<leader>sb', function() snacks.picker.lines() end, { desc = 'Buffer Lines' })
      vim.keymap.set('n', '<leader>sB', function() snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
      vim.keymap.set('n', '<leader>sg', function() snacks.picker.grep({ dirs = { vim.fn.getcwd() } }) end,
        { desc = 'Grep' })
      vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() snacks.picker.grep_word() end,
        { desc = 'Visual selection or word' })
      -- search
      vim.keymap.set('n', "<leader>s'", function() snacks.picker.registers() end, { desc = 'Registers' })
      vim.keymap.set('n', '<leader>sa', function() snacks.picker.autocmds() end, { desc = 'Autocmds' })
      vim.keymap.set('n', '<leader>sc', function() snacks.picker.command_history() end, { desc = 'Command History' })
      vim.keymap.set('n', '<leader>sC', function() snacks.picker.commands() end, { desc = 'Commands' })
      -- vim.keymap.set('n', '<leader>sd', function() snacks.picker.diagnostics() end, {desc = 'Diagnostics' },
      vim.keymap.set('n', '<leader>sh', function() snacks.picker.help() end, { desc = 'Help Pages' })
      vim.keymap.set('n', '<leader>sj', function() snacks.picker.jumps() end, { desc = 'Jumps' })
      vim.keymap.set('n', '<leader>sk', function() snacks.picker.keymaps() end, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>sM', function() snacks.picker.man() end, { desc = 'Man Pages' })
      vim.keymap.set('n', '<leader>sm', function() snacks.picker.marks() end, { desc = 'Marks' })
      vim.keymap.set('n', '<leader>sR', function() snacks.picker.resume() end, { desc = 'Resume Snacks Picker' })
      vim.keymap.set('n', '<leader>qp', function() snacks.picker.projects() end, { desc = 'Projects' })
      -- misc
      vim.keymap.set('n', '<leader>tt', function() snacks.picker.colorschemes() end, { desc = 'Pick theme' })
      vim.keymap.set('n', '<leader>tz', function() snacks.zen.zoom() end, { desc = 'Zoom window' })
      -- LSP
      -- vim.keymap.set('n', 'gd', function() snacks.picker.lsp_definitions() end, {desc = 'Goto Definition' })
      -- vim.keymap.set('n', 'gD', function() snacks.picker.lsp_declarations() end, {desc = 'Goto Declaration' })
      -- vim.keymap.set('n', '<leader>gr', function() snacks.picker.lsp_references() end, {nowait = true, desc = 'References' })
      -- vim.keymap.set('n', 'gI', function() snacks.picker.lsp_implementations() end, {desc = 'Goto Implementation' })
      -- vim.keymap.set('n', 'gy', function() snacks.picker.lsp_type_definitions() end, {desc = 'Goto T[y]pe Definition' })
      -- vim.keymap.set('n', '<leader>ls', function() snacks.picker.lsp_symbols() end, {desc = 'Buffer Symbols' })
    end,
  }
}
