return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gdiffsplit' },
    enabled = false,
    dependencies = { 'tpope/vim-rhubarb' },
    keys = {
      { '<leader>gs', '<cmd>tab Git<cr>', desc = '[G]it [S]tatus' },
      { '<leader>gdf', '<cmd>Gdiffsplit<cr>', desc = '[G]it [D]iff [F]ile' },
      { '<leader>gb', '<cmd>Git blame<cr>', desc = '[G]it [B]lame' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = '[G]it [C]ommit' },
      { '<leader>gp', '<cmd>Git pull<cr>', desc = '[G]it [P]ull' },
      { '<leader>gP', '<cmd>Git push<cr>', desc = '[G]it [P]ush' },

      -- { '<leader>gbb', '<cmd>Git branch<cr>', desc = '[G]it [B]ranch [B]rowse' },
      -- { '<leader>gpf', '<cmd>Git push --force-with-lease<cr>', desc = '[G]it [P]ush [F]orce' },

      -- { '<leader>goc', '<cmd>GBrowse<cr>', desc = '[G]it [H]ub [O]pen' },
      { '<leader>goc', '<cmd>.GBrowse<cr>', desc = '[G]it [O]pen [C]ommit' },
      -- { '<leader>gll', '<cmd>Gclog<cr>', desc = '[G]it [L]og' },
      {
        '<leader>glg',
        function()
          vim.cmd 'tab Git log --graph'
          vim.cmd 'only' -- Close other windows in the tab
        end,
        desc = '[G]it [L]og [G]raph (fullscreen)',
      },
    },
  },
}
