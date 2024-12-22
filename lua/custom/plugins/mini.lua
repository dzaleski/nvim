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
  {
    'echasnovski/mini.clue',
    enabled = false,
    config = function()
      require('mini.clue').setup {
        triggers = {
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },
          { mode = 'i', keys = '<C-x>' },
        },
        clues = {
          require('mini.clue').gen_clues.builtin_completion(),
          require('mini.clue').gen_clues.g(),
          require('mini.clue').gen_clues.marks(),
          require('mini.clue').gen_clues.registers(),
          require('mini.clue').gen_clues.windows(),
          {
            mode = 'n',
            keys = '<Leader>g',
            desc = '+Git',
            postkeys = { '<Leader>g' },
          },
          {
            mode = 'n',
            keys = '<Leader>s',
            desc = '+Search',
            postkeys = { '<Leader>s' },
          },
        },
        window = {
          delay = 300,
          config = { width = 'auto', border = 'rounded' },
        },
      }
    end,
  },
}
