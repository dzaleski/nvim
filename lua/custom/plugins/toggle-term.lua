return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 20, -- Default terminal size
    open_mapping = [[<c-\>]], -- Use Ctrl+\ to toggle terminal
    direction = 'float', -- Set terminal to float mode
    shade_filetypes = { 'nofile' }, -- Prevent shading for certain filetypes
    close_on_exit = true, -- Close terminal automatically when command finishes
    shell = vim.o.shell, -- Use the default shell
    float_opts = {
      border = 'single', -- Border style for floating terminal
      winblend = 3, -- Transparency for floating terminal
    },
  },
  config = function()
    require('toggleterm').setup {
      size = 20,
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
      shade_filetypes = { 'nofile' },
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'single',
        winblend = 3,
      },
    }

    -- Terminal with specific index
    vim.keymap.set('n', '<leader>t', '<cmd>1ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>t2', '<cmd>2ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })

    vim.keymap.set('n', '<leader>t3', '<cmd>3ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })

    local exitTerm = function()
      vim.cmd ':ToggleTerm'
    end

    vim.keymap.set('t', '<esc><esc>', exitTerm, { noremap = true, silent = true })
  end,
}
