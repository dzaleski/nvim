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
    local snacks = require 'snacks.picker'
    local filetype = vim.bo[bufnr].filetype

    -- LSP navigation mappings using snacks.nvim
    keymap('n', 'gd', function()
      snacks.lsp_definitions {
        layout = {
          preset = 'dropdown',
        },
      }
    end, { desc = '[G]oto [D]efinition', buffer = bufnr })
    keymap('n', 'gr', function()
      snacks.lsp_references {
        layout = {
          preset = 'dropdown',
        },
      }
    end, { desc = '[G]oto [R]eferences', buffer = bufnr })
    keymap('n', 'gI', function()
      snacks.lsp_implementations {
        layout = {
          preset = 'dropdown',
        },
      }
    end, { desc = '[G]oto [I]mplementation', buffer = bufnr })
    keymap('n', 'gt', function()
      snacks.lsp_type_definitions {
        layout = {
          preset = 'dropdown',
        },
      }
    end, { desc = 'Type [D]efinition', buffer = bufnr })
    keymap('n', '<leader>i', function()
      snacks.lsp_symbols {
        layout = {
          preset = 'dropdown',
        },
      }
    end, { desc = '[D]ocument [S]ymbols', buffer = bufnr })
    keymap('n', '<leader>I', function()
      snacks.lsp_workspace_symbols {
        layout = {
          preset = 'dropdown',
        },
      }
    end, { desc = '[W]orkspace [S]ymbols', buffer = bufnr })
    keymap('n', '<leader>r', vim.lsp.buf.rename, { desc = '[R]ename', buffer = bufnr })
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

    if client and client.name == 'typescript-tools' and (filetype == 'typescript' or filetype == 'javascript') then
      -- Disable renaming if Angular Language Service is active
      if vim.lsp.get_clients { bufnr = args.buf, name = 'angularls' } then
        client.server_capabilities.renameProvider = false
      end

      -- Command for manual import organization
      vim.api.nvim_buf_create_user_command(args.buf, 'OrganizeImports', function()
        vim.lsp.buf.execute_command {
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
      end, { desc = 'Organize TypeScript imports' })

      -- Automatic import organization on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          -- Check if we have an active LSP client
          local clients = vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }
          for _, lsp_client in ipairs(clients) do
            if lsp_client.name == 'typescript-tools' then
              vim.lsp.buf.execute_command {
                command = '_typescript.organizeImports',
                arguments = { vim.api.nvim_buf_get_name(0) },
              }

              vim.cmd 'silent! Prettier'
              break
            end
          end
        end,
      })
    end

    -- Document highlight configuration
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

-- Enhanced diagnostics configuration
vim.diagnostic.config {
  virtual_text = {
    spacing = 4,
    prefix = '●',
    format = function(diagnostic)
      return string.format('%s (%s) %s', diagnostic.message, diagnostic.source or '', diagnostic.code or '')
    end,
    hl_mode = 'combine',
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
  },
  float = {
    border = 'rounded',
    source = 'if_many',
    format = function(diagnostic)
      return string.format('%s\n\n[%s] %s', diagnostic.message, diagnostic.source or '', diagnostic.code or '')
    end,
    header = { 'Diagnostics:', 'Normal' },
    prefix = function(diagnostic, i, total)
      local icon, hl
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        icon, hl = ' ', 'DiagnosticError'
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        icon, hl = ' ', 'DiagnosticWarn'
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        icon, hl = ' ', 'DiagnosticInfo'
      else
        icon, hl = ' ', 'DiagnosticHint'
      end
      return icon .. ' ', hl
    end,
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
    undercurl = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
  severity_sort = true,
  update_in_insert = false,
}

-- Add this for enhanced variable/argument diagnostics
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- Enable semantic tokens for better variable/argument highlighting
      if client.supports_method 'textDocument/semanticTokens/full' then
        vim.lsp.semantic_tokens.start(args.buf, client.id)
      end
    end
  end,
})

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
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
      'folke/snacks.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      capabilities.textDocument.signatureHelp = { dynamicRegistration = true }

      -- Enable semantic tokens capability
      capabilities.textDocument.semanticTokens = {
        dynamicRegistration = true,
        tokenTypes = {
          'namespace',
          'type',
          'class',
          'enum',
          'interface',
          'struct',
          'typeParameter',
          'parameter',
          'variable',
          'property',
          'enumMember',
          'event',
          'function',
          'method',
          'macro',
          'keyword',
          'modifier',
          'comment',
          'string',
          'number',
          'regexp',
          'operator',
        },
        tokenModifiers = {
          'declaration',
          'definition',
          'readonly',
          'static',
          'deprecated',
          'abstract',
          'async',
          'modification',
          'documentation',
          'defaultLibrary',
        },
        formats = { 'relative' },
        requests = { range = true, full = { delta = true } },
        multilineTokenSupport = false,
        overlappingTokenSupport = false,
      }

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
              semantic = { enable = true }, -- Enable semantic highlighting for Lua
            },
          },
        },
        angularls = {
          filetypes = { 'typescript', 'htmlangular' },
        },
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
            -- Enable more detailed semantic tokens
            semanticTokens = true,
          },
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
          'lua_ls',
          'stylua',
          'eslint',
          'html',
          'cssls',
          'roslyn',
          -- 'typescript-language-server', -- using typescript-tools instead
          'angular-language-server',
          'prettier',
          'prettierd',
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
