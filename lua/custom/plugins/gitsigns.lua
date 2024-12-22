return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎', texthl = 'GitSignsAdd' },
        change = { text = '▎', texthl = 'GitSignsChange' },
        delete = { text = '', texthl = 'GitSignsDelete' },
        topdelete = { text = '', texthl = 'GitSignsDelete' },
        changedelete = { text = '▎', texthl = 'GitSignsChange' },
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'Git: ' .. desc })
        end

        -- Navigation
        map('n', ']c', function()
          gs.nav_hunk 'next'
        end, 'Next [C]hange (hunk)')

        map('n', '[c', function()
          gs.nav_hunk 'prev'
        end, 'Prev [C]hange (hunk)')

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', function()
          if vim.fn.mode() == 'v' then
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          else
            gs.stage_hunk()
          end
        end, 'Stage Hunk')

        map({ 'n', 'v' }, '<leader>hr', function()
          if vim.fn.mode() == 'v' then
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          else
            gs.reset_hunk()
          end
        end, 'Reset Hunk')

        -- Blame
        map('n', '<leader>hb', gs.blame_line, 'Line Blame')
        map('n', '<leader>hB', function()
          if vim.b.gitsigns_blame_line_enabled then
            gs.toggle_current_line_blame()
          end
          vim.cmd 'Git blame'
        end, 'Whole File Blame')

        -- Diff
        map('n', '<leader>hd', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>hD', gs.diffthis, 'Diff Index')

        -- Toggles
        map('n', '<leader>ht', gs.toggle_current_line_blame, 'Toggle Line Blame')
        map('n', '<leader>hT', gs.toggle_deleted, 'Toggle Deleted')
      end,
    },
  },
}
