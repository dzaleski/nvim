return {
  'phaazon/hop.nvim',
  branch = 'v2',
  config = function()
    require('hop').setup {
      keys = 'etovxqpdygfblzhckisuran',
    }

    vim.keymap.set('n', 's', '<cmd>HopWordAC<CR>', { noremap = true })
    vim.keymap.set('n', 'S', '<cmd>HopWordBC<CR>', { noremap = true })
  end,
}
