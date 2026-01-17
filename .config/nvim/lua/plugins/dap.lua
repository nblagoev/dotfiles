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
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'igorlfs/nvim-dap-view',
        opts = {
          winbar = {
            sections = { 'scopes', 'breakpoints', 'threads', 'exceptions', 'repl', 'console' },
            default_section = 'scopes',
            controls = { enabled = false }
          },
          -- When jumping through the call stack, try to switch to the buffer if already open in
          -- a window, else use the last window to open the buffer.
          switchbuf = 'usetab,uselast',
        },
      },
      -- Virtual text.
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = { virt_text_pos = 'eol' },
      },
      -- Lua adapter.
      {
        'jbyuki/one-small-step-for-vimkind',
        keys = {
          { '<leader>dl', function() require('osv').launch { port = 8086 }  end, desc = 'Launch Lua adapter' },
        },
      },
    },
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint', },
      -- { '<leader>dB', '<cmd>FzfLua dap_breakpoints<cr>', desc = 'List breakpoints', },
      { '<leader>dc', function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, desc = 'Breakpoint condition' },
      { '<F7>', function() require('dap').step_into() end, desc = 'Step into' },
      { '<F8>', function() require('dap').step_over() end, desc = 'Step over' },
      { '<S-F8>', function() require('dap').step_out() end, desc = 'Step out' },
      { '<F9>', function() require('dap').continue() end, desc = 'Continue' },
    },
    config = function()
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

      -- Rust configurations.
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
  },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
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

    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    keys = {
      { "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", mode = "v" },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.python_remote = {
    		type = "server",
    		host = "127.0.0.1",
    		port = 5678,
     	}
      require("dap-python").resolve_python = function()
        return "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3"
      end
      require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
    end,
  },
}
