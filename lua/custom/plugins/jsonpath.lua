return {
  'phelipetls/jsonpath.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'BufReadPre',
  ft = { 'json', 'jsonc' },
  config = function()
    vim.keymap.set('n', '<leader>cjp', function()
      local path = require('jsonpath').get()

      -- Remove the first dot, if it exists, and wrap the path in single quotes
      local formatted_path = path:match '^%.(.*)' or path
      formatted_path = "'" .. formatted_path .. "'"

      -- Copy the formatted path to the clipboard
      vim.fn.setreg('+', formatted_path)

      vim.notify('Copied path: ' .. formatted_path, vim.log.levels.INFO)
    end, { desc = 'Copy JSON Path', noremap = true, silent = true })
  end,
}
