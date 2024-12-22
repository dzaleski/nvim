return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  {
    'artemave/workspace-diagnostics.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<space>x', '', {
        noremap = true,
        callback = function()
          for _, client in ipairs(vim.lsp.buf_get_clients()) do
            require('workspace-diagnostics').populate_workspace_diagnostics(client, 0)
          end
        end,
      })
    end,
  },
}
