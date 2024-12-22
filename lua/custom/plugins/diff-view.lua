return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('diffview.config').actions

      require('diffview').setup {
        keymaps = {
          file_panel = {
            ['<Space>'] = require('diffview.config').actions.toggle_stage_entry,
            ['<C-d>'] = actions.scroll_view(0.45),
            ['<D-d>'] = actions.scroll_view(0.45),
            ['<C-u>'] = actions.scroll_view(-0.45),
            ['<D-u>'] = actions.scroll_view(-0.45),
            ['q'] = actions.close,
          },
          view = {
            ['q'] = actions.close,
          },
        },
      }

      vim.keymap.set('n', '<leader>gdv', function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd 'DiffviewOpen'
        else
          vim.cmd 'DiffviewClose'
        end
      end, { desc = '[G]it [D]iff [V]iew (toggle)' })
    end,
  },
}
