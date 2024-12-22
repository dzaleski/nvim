return {
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        manual_mode = false,
        detection_methods = { 'lsp', 'pattern' },
        patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
        datapath = vim.fn.stdpath 'data',
      }

      -- Telescope integration
      require('telescope').load_extension 'projects'
      local telescope = require 'telescope'

      -- Default project.nvim Telescope picker mappings
      vim.keymap.set('n', '<leader>fp', telescope.extensions.projects.projects, { desc = '[F]ind [P]rojects' })
    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}
