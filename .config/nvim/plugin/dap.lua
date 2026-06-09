local add = require('vim-pack').add
local add_on_event = require('vim-pack').add_on_event
local add_on_filetype = require('vim-pack').add_on_file_type

local dap_icons = require('icons').dap

-- Set up icons.
local icons = {
  Stopped = { dap_icons.Stopped, 'DiagnosticWarn', 'DapStoppedLine' },
  Breakpoint = dap_icons.Breakpoint,
  BreakpointCondition = dap_icons.BreakpointConditional,
  BreakpointRejected = { dap_icons.BreakpointRejected, 'DiagnosticError' },
  LogPoint = dap_icons.BreakpointLog,
}
for name, sign in pairs(icons) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define('Dap' .. name, {
    -- stylua: ignore
    text = sign[1] --[[@as string]] .. ' ',
    texthl = sign[2] or 'DiagnosticInfo',
    linehl = sign[3],
    numhl = sign[3],
  })
end

-- Debugging.
add_on_event('UIEnter', {
  -- Lua adapter.
  {
    src = 'jbyuki/one-small-step-for-vimkind',
    setup = false,
    on_setup = function(opts)
      vim.keymap.set('n', '<leader>dl', function()
        require('osv').launch { port = 8086 }
      end, { desc = 'Launch Lua adapter' })
    end,
  },
})

add {
  {
    src = 'igorlfs/nvim-dap-view',
    module_name = 'dap-view',
    opts = {
      winbar = {
        sections = { 'scopes', 'breakpoints', 'threads', 'exceptions', 'repl', 'console' },
        default_section = 'scopes',
        controls = { enabled = false },
      },
      windows = { size = 18 },
      -- When jumping through the call stack, try to switch to the buffer if already open in
      -- a window, else use the last window to open the buffer.
      switchbuf = 'usetab,uselast',
    },
  },
  -- Virtual text.
  {
    src = 'theHamsta/nvim-dap-virtual-text',
    opts = { virt_text_pos = 'eol' },
  },
  {
    src = 'mfussenegger/nvim-dap',
    setup = false,
    on_setup = function(opts)
      vim.keymap.set('n', '<leader>db', function()
        require('dap').toggle_breakpoint()
      end, { desc = 'Toggle breakpoint' })

      -- vim.keymap.set('n', '<leader>dB', '<cmd>FzfLua dap_breakpoints<cr>', { desc = 'List breakpoints' })

      vim.keymap.set('n', '<leader>dc', function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Conditional breakpoint' })

      vim.keymap.set('n', '<F9>', function()
        require('dap').continue()
      end, { desc = 'Continue' })

      vim.keymap.set('n', '<F8>', function()
        require('dap').step_over()
      end, { desc = 'Step over' })

      vim.keymap.set('n', '<F7>', function()
        require('dap').step_into()
      end, { desc = 'Step into' })

      vim.keymap.set('n', '<S-F8>', function()
        require('dap').step_out()
      end, { desc = 'Step out' })

      local dap = require 'dap'
      local dv = require 'dap-view'

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('nbl/dap_options', { clear = true }),
        desc = 'Set options for DAP UI',
        pattern = 'dap-view',
        callback = function()
          vim.wo[0][0].listchars = 'space: ,tab:   '
        end,
      })

      -- Automatically open the UI when a new debug session is created.
      dap.listeners.before.attach['dap-view-config'] = function()
        dv.open()
      end
      dap.listeners.before.launch['dap-view-config'] = function()
        dv.open()
      end
      dap.listeners.before.event_terminated['dap-view-config'] = function()
        dv.close()
      end
      dap.listeners.before.event_exited['dap-view-config'] = function()
        dv.close()
      end

      -- Lua configurations.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'lua',
        once = true,
        callback = function()
          dap.adapters.nlua = function(callback, config)
            callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
          end
          dap.configurations['lua'] = {
            {
              type = 'nlua',
              request = 'attach',
              name = 'Attach to running Neovim instance',
            },
          }
        end,
      })

      -- Rust configurations.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'rust',
        once = true,
        callback = function()
          local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = mason_path .. "bin/codelldb",
              args = { "--port", "${port}" },
            },
          }
          dap.configurations['rust'] = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
          }
        end,
      })
    end,
  },
}

add_on_filetype('go', {
  {
    src = "leoluz/nvim-dap-go",
    module_name = "dap-go",
    opts = {
      dap_configurations = {
        {
          -- Must be "go" or it will be ignored by the plugin
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      -- delve configurations
      delve = {
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port
        port = "${port}",
      },
    },
  },
})

add_on_filetype('python', {
  {
    src = "mfussenegger/nvim-dap-python",
    module_name = "dap-python",
    setup = false,
    on_setup = function(opts)
      local dap = require("dap")
      dap.adapters.python_remote = {
        type = "server",
        host = "127.0.0.1",
        port = 5678,
      }
      -- require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
      require("dap-python").setup('debugpy-adapter')
    end
  },
})
