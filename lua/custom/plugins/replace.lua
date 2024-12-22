return {
  'vim-scripts/ReplaceWithRegister',
  opts = {},
  config = function()
    -- Replace plugin keymaps
    vim.keymap.set('n', 'r', '<Plug>ReplaceWithRegisterOperator', { desc = 'Replace with Register plugin' })

    -- Replace the entire line with register content when pressing 'rr'
    vim.keymap.set('n', 'rr', '0<Plug>ReplaceWithRegisterOperator$', { desc = 'Replace entire line with register content' })

    -- Default replace functionality moved to capital R
    vim.keymap.set('n', 'R', 'r', { desc = 'Single-character replace' })
  end,
}
