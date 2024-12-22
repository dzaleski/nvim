return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
          timeout_ms = 3000,
        }
      end,
      mode = '',
      desc = '[F]ormat [F]ile',
    },
  },
  config = function()
    require('conform').setup {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'eslint', 'prettier' },
        javascript = { 'eslint', 'prettier' },
        typescriptreact = { 'eslint', 'prettier' },
        javascriptreact = { 'eslint', 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        -- Dodaj inne formatery według potrzeb
      },
      formatters = {
        eslint = {
          command = 'eslint',
          args = { '--fix', '--stdin', '--stdin-filename', '$FILENAME' },
          stdin = true,
          cwd = function(ctx)
            return vim.fn.fnamemodify(ctx.filename, ':h')
          end,
        },
        prettier = {
          prepend_args = { '--config-precedence', 'prefer-file' },
        },
        stylua = {
          command = 'stylua',
          args = { '--search-parent-directories', '-' },
          stdin = true,
        },
      },
    }

    vim.keymap.set('n', '<leader>W', function()
      vim.g.disable_autoformat = true
      vim.cmd 'write'
      vim.g.disable_autoformat = false
    end, { desc = 'Save [W]ithout Formatting' })
  end,
}
