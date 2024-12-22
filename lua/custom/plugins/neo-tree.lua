return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>e',
        function()
          if vim.bo.filetype == 'neo-tree' then
            vim.cmd 'Neotree close'
          else
            vim.cmd 'Neotree reveal'
          end
        end,
        desc = 'Toggle Neo-tree visibility',
      },
    },
    opts = {
      filesystem = {
        follow_current_file = true,
        window = {
          mappings = {
            ['h'] = 'close_node',
            ['l'] = 'open',
            ['<CR>'] = 'open',
          },
        },
      },
    },
  },
}
