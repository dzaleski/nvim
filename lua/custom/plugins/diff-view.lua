return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Required dependency
    config = function()
      require('diffview').setup {
        keymaps = {
          file_panel = {
            ['<Space>'] = require('diffview.config').actions.toggle_stage_entry,
          },
        },
      }

      vim.keymap.set('n', '<leader>dv', function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd 'DiffviewOpen'
        else
          vim.cmd 'DiffviewClose'
        end
      end)
    end,
  },
}
