return {
  'MagicDuck/grug-far.nvim',
  config = function()
    local grug_far = require 'grug-far'

    grug_far.setup {
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
    }

    vim.keymap.set('n', '<leader>fr', grug_far.open, { desc = 'Launch Grug-Far' })
  end,
}
