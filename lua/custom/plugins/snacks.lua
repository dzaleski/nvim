return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      previewers = {
        diff = {
          builtin = false,
          cmd = { 'delta' },
        },
      },
    },
    explorer = {},
    indent = {
      animate = {
        enabled = false,
      },
    },
    bufdelete = {},
    input = {},
    scope = {},
    lazygit = {
      win = {
        width = 0.95,
        height = 0.95,
      },
      config = {
        gui = {
          windowDimensions = {
            width = 0.95,
            height = 0.95,
          },
          sidePanelWidth = 0.25,
          filterMode = 'fuzzy',
          enlargedSideViewLocation = 'top',
          scrollOffBehavior = 'jump',
          scrollHeight = 12,
        },
        git = {
          paging = {
            pager = 'delta --dark --paging=never',
            useConfig = false,
          },
        },
      },
    },
    gitbrowse = {},
  },
  keys = {
    {
      '<leader>gor',
      function()
        Snacks.gitbrowse()
      end,
      desc = '[G]it [O]pen [R]remote',
    },
    {
      '<leader><tab>',
      function()
        Snacks.lazygit()
        vim.defer_fn(function()
          vim.fn.chansend(vim.b.terminal_job_id, '+')
        end, 50)
      end,
      desc = 'Open LazyGit',
    },
    {
      '<A-w><A-l>',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Close all buffers but current',
    },
    {
      '<leader>o',
      function()
        Snacks.picker.smart {
          layout = {
            preset = 'select',
          },
        }
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers {
          layout = {
            preset = 'dropdown',
          },
        }
      end,
      desc = 'Buffers',
    },
    {
      '<leader>[',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history { layout = { preset = 'select' } }
      end,
      desc = 'Command History',
    },
    -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },
    -- find
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config', layout = {
          preset = 'select',
        } }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files { layout = {
          preset = 'select',
        } }
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files {
          layout = {
            preset = 'select',
          },
        }
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects {
          layout = {
            preset = 'select',
          },
        }
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },

    -- git
    {
      '<leader>fb',
      function()
        Snacks.picker.git_branches {
          layout = {
            preset = 'select',
          },
        }
      end,
      desc = '[F]ind [B]ranches',
    },
    {
      '<leader>gLl',
      function()
        Snacks.lazygit.log()
      end,
      desc = '[G]it [L]azyGit [L]og',
    },
    {
      '<leader>gLf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = '[G]it [L]azyGit Log [F]ile',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.git_log()
      end,
      desc = '[F]ind Git [C]ommits (Log)',
    },
    {
      '<leader>gll',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = '[G]it [L]og [L]ine',
    },
    {
      '<leader>glf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = '[G]it [L]og [F]ile',
    },
    {
      '<leader>fs',
      function()
        Snacks.picker.git_status()
      end,
      desc = '[F]ind Git [S]tatus',
    },
    {
      '<leader>fS',
      function()
        Snacks.picker.git_stash {
          layout = {
            preset = 'left',
          },
        }
      end,
      desc = '[F]ind Git [S]tash',
    },
    {
      '<leader>fd',
      function()
        Snacks.picker.git_diff {
          layout = {
            preset = 'left',
          },
        }
      end,
      desc = '[F]ind Git [D]iff (Hunks)',
    },
    -- Grep
    {
      '<leader>/',
      function()
        Snacks.picker.lines { layout = {
          preset = 'select',
        } }
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },

    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history { layout = {
          preset = 'select',
        } }
      end,
      desc = 'Search History',
    },
    -- { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    -- { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    {
      '<leader>p',
      function()
        Snacks.picker.commands { layout = {
          preset = 'select',
        } }
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics { layout = {
          preset = 'dropdown',
        } }
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer { layout = {
          preset = 'dropdown',
        } }
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    -- { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps { layout = {
          preset = 'dropdown',
        } }
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps { layout = {
          preset = 'select',
        } }
      end,
      desc = 'Keymaps',
    },
    -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks { layout = {
          preset = 'dropdown',
        } }
      end,
      desc = 'Marks',
    },
    -- { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    {
      '<leader>sp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>fu',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>u',
      function()
        Snacks.picker.cliphist {
          finder = 'system_cliphist',
          format = 'text',
          preview = 'preview',
          confirm = { 'copy', 'close' },
        }
      end,
      desc = 'Undo History',
    },
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
  },
}
