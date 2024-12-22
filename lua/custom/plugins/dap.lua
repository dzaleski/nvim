return {
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup {
        icons = {
          expanded = '',
          collapsed = '',
          current_frame = '',
          circular = '',
        },
        controls = {
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
          },
        },
        floating = {
          border = 'rounded',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            position = 'left',
            size = 30,
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            position = 'bottom',
            size = 5,
          },
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mxsdev/nvim-dap-vscode-js',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '󰜴',
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '',
        texthl = 'DapBreakpointRejected',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapStopped', {
        text = '',
        texthl = 'DapStopped',
        linehl = 'DebugLine',
        numhl = 'DebugNum',
      })

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#fc5d7c', bold = true })
      vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#78dce8', bold = true })
      vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#ff6188', bold = true })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#a9dc76', bold = true })
      vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#ff0000', bold = true })

      vim.api.nvim_set_hl(0, 'DebugLine', {
        bg = '#423a4d',
        bold = true,
        underline = true,
      })
      vim.api.nvim_set_hl(0, 'DebugNum', {
        fg = '#ff0000',
        bg = '#423a4d',
        bold = true,
      })

      local function get_chromium_path()
        local paths = {
          -- Add Windows Chrome/Edge paths via WSL path format
          '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe',
          '/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe',
          '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe',

          '/usr/bin/chromium',
          '/usr/bin/chromium-browser',
          '/snap/bin/chromium',

          'C:\\Program Files\\Chromium\\Application\\chrome.exe',

          '/Applications/Chromium.app/Contents/MacOS/Chromium',

          'google-chrome-stable',
          'chrome',
        }

        for _, path in ipairs(paths) do
          if vim.fn.executable(path) == 1 then
            return path
          end
        end

        vim.notify('Chromium not found! Please install or set runtimeExecutable manually', vim.log.levels.WARN)
        return nil
      end

      dap.adapters.chrome = {
        type = 'executable',
        command = 'node',
        args = {
          vim.fn.stdpath 'data' .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js',
        },
      }

      dap.configurations.typescript = {
        {
          type = 'chrome',
          request = 'launch',
          name = 'Debug Angular (Chromium)',
          url = 'http://localhost:4200',
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
          trace = true,
          runtimeExecutable = get_chromium_path(),
          userDataDir = '${workspaceFolder}/.chromium-debug',
          skipFiles = { 'node_modules/**' },
          sourceMapPathOverrides = {
            ['webpack:///./*'] = '${webRoot}/*',
            ['webpack:///src/*'] = '${webRoot}/src/*',
          },
        },
      }

      local function setup_debug_keymaps()
        vim.keymap.set('n', '<Leader>dj', dap.continue, { desc = '▶ Continue Debugging' })
        vim.keymap.set('n', '<Leader>ds', dap.terminate, { desc = '⏹ Stop Debugging' })
        vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '🔘 Toggle Breakpoint' })
        vim.keymap.set('n', '<Leader>dcb', function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = '❓ Conditional Breakpoint' })

        vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '↓ Step Into' })
        vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '→ Step Over' })
        vim.keymap.set('n', '<Leader>du', dap.step_out, { desc = '↑ Step Out' })
        vim.keymap.set('n', '<Leader>dr', dap.restart, { desc = '🔄 Restart Debugging' })
        vim.keymap.set('n', '<Leader>dn', function()
          require('dap').goto_()
        end, { desc = '➡️ Go to next breakpoint' })

        vim.keymap.set('n', '<Leader>drb', dap.clear_breakpoints, { desc = '❌ Remove All Breakpoints' })
        vim.keymap.set('n', '<Leader>deb', function()
          require('dap').set_breakpoints(nil, nil, true)
        end, { desc = '✅ Enable All Breakpoints' })
        vim.keymap.set('n', '<Leader>ddb', function()
          require('dap').set_breakpoints(nil, nil, false)
        end, { desc = '🚫 Disable All Breakpoints' })

        vim.keymap.set('n', '<Leader>dp', dapui.toggle, { desc = '📊 Toggle Debug UI' })
        vim.keymap.set('n', '<Leader>dh', function()
          require('dap.ui.widgets').hover()
        end, { desc = '🔍 Hover Variables' })
        vim.keymap.set('n', '<Leader>df', function()
          require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)
        end, { desc = '🖼️ Show Frames' })
        vim.keymap.set('n', '<Leader>dv', function()
          require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)
        end, { desc = '📦 Show Variables' })
      end

      setup_debug_keymaps()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open { reset = true }
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = true,
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      }

      vim.api.nvim_set_hl(0, 'NvimDapVirtualText', { fg = '#78dce8', bg = '#363946', bold = true })
      vim.api.nvim_set_hl(0, 'NvimDapVirtualTextChanged', { fg = '#a9dc76', bg = '#363946', bold = true })
    end,
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    config = function()
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
        adapters = { 'pwa-chromium' },
      }
    end,
  },
}
