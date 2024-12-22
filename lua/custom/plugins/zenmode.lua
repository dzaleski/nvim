return {
  'folke/zen-mode.nvim',
  opts = {
    -- You can add additional configuration here if needed
  },
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>tz', ':ZenMode<CR>', { noremap = true, silent = true })
  end,
}
