return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat [F]ile',
    },
  },
  config = function()
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
          return nil
        end

        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        html = { 'prettier' },
        htmlangular = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        csharp = { 'csharpier' },
      },
    }

    vim.keymap.set('n', '<leader>swf', function()
      vim.g.disable_autoformat = true
      vim.cmd 'write'
      vim.g.disable_autoformat = false
    end, { desc = '[S]ave [W]ithout [F]ormatting' })
  end,
}
