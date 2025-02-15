local function keymap(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = true
  opts.desc = string.format('Lsp: %s', opts.desc)
  vim.keymap.set(mode, l, r, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('DefaultLspAttach', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Define your mappings here
    keymap('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition', buffer = bufnr })
    keymap('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences', buffer = bufnr })
    keymap('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation', buffer = bufnr })
    keymap('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, { desc = 'Type [D]efinition', buffer = bufnr })
    keymap('n', '<leader>i', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols', buffer = bufnr })
    keymap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols', buffer = bufnr })
    keymap('n', '<leader>r', vim.lsp.buf.rename, { desc = '[R]e[n]ame', buffer = bufnr })
    keymap({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', buffer = bufnr })

    keymap('n', 'gh', function()
      vim.lsp.buf.hover { border = CUSTOM_BORDER }
    end, { desc = '[H]over', buffer = bufnr })

    keymap('i', '<C-s>', function()
      vim.lsp.buf.signature_help { border = CUSTOM_BORDER }
    end, { desc = '[S]ignature [H]elp', buffer = bufnr })

    keymap('i', '<D-s>', function()
      vim.lsp.buf.signature_help { border = CUSTOM_BORDER }
    end, { desc = '[S]ignature [H]elp', buffer = bufnr })

    -- Document highlight
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.diagnostic.config {
  virtual_text = { spacing = 4, prefix = '●' },
  ---@diagnostic disable-next-line: assign-type-mismatch
  float = { border = CUSTOM_BORDER, source = 'if_many' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignHint',
    },
  },
}

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
      'seblj/roslyn.nvim',
    },
    config = function()
      -- Extracted capabilities for LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      capabilities.textDocument.signatureHelp = { dynamicRegistration = true }

      -- LSP servers configuration
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
            },
          },
        },
        angularls = {
          filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
        },
      }

      require('mason').setup {
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'lua_ls', -- Lua Language Server
          'stylua', -- Lua Formatter
          'eslint', -- JavaScript/TypeScript Linter
          'html', -- HTML Language Server
          'cssls', -- CSS Language Server
          'roslyn', -- C# Language Server
          -- 'csharpier', -- C# Formatter
          'typescript-language-server', -- TypeScript Language Server
          'angular-language-server', -- Angular Language Server
          'prettier',
          'prettierd',
          -- 'netcoredbg',
          'chrome-debug-adapter',
          'jsonls',
        },
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
