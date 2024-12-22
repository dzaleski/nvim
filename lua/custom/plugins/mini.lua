return {
  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require('mini.ai').setup()
    end,
  },
  {
    'echasnovski/mini.operators',
    version = false,
    config = function()
      -- Fallback to normal replace
      vim.keymap.set('n', 'R', 'r')

      require('mini.operators').setup { replace = { prefix = 'r' }, multiply = { prefix = 'm' } }
    end,
  },
}
