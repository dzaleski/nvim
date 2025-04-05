return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gdiffsplit' },
    dependencies = { 'tpope/vim-rhubarb' },
    keys = {
      { '<leader><tab>', '<cmd>tab Git<cr>', desc = '[G]it [S]tatus' },
      -- { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = '[G]it [D]iff' },
      -- { '<leader>gb', '<cmd>Git blame<cr>', desc = '[G]it [B]lame' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = '[G]it [C]ommit' },
      { '<leader>gp', '<cmd>Git pull<cr>', desc = '[G]it [P]ull' },
      { '<leader>gP', '<cmd>Git push<cr>', desc = '[G]it [P]ush' },

      -- { '<leader>gbb', '<cmd>Git branch<cr>', desc = '[G]it [B]ranch [B]rowse' },
      -- { '<leader>gpf', '<cmd>Git push --force-with-lease<cr>', desc = '[G]it [P]ush [F]orce' },

      { '<leader>gho', '<cmd>GBrowse<cr>', desc = '[G]it [H]ub [O]pen' },
      { '<leader>ghc', '<cmd>.GBrowse<cr>', desc = '[G]it [H]ub [C]ursor' },
      { '<leader>gll', '<cmd>Gclog<cr>', desc = '[G]it [L]og' },
      {
        '<leader>glg',
        function()
          vim.cmd 'tab Git log --graph'
          vim.cmd 'only' -- Close other windows in the tab
        end,
        desc = '[G]it [L]og [G]raph (fullscreen)',
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fugitive',
        callback = function()
          vim.cmd 'wincmd =' -- Equalize windows
          vim.opt_local.number = false
          vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true })

          vim.keymap.set('n', '<leader>go', 'yiw:Git checkout <C-r>"<cr>', { buffer = true, desc = 'Checkout branch under cursor' })
        end,
      })
    end,
  },
}
