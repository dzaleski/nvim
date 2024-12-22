return {
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      {
        '<leader>U',
        ':UndotreeToggle<CR>',
        desc = 'Toggle UndoTree',
      },
    },
    config = function()
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_Diffcommand = ''
    end,
  },
}
