return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  opts = {
    on_attach = function(client, bufnr)
      -- Mappings for TypeScript-specific functionality
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Code navigation
      map('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<cr>', 'Go to source definition')
      map('n', 'gD', '<cmd>TSToolsGoToSourceDefinition<cr>', 'Go to source definition')
      map('n', 'gr', '<cmd>TSToolsReferences<cr>', 'Find references')
      map('n', 'gi', '<cmd>TSToolsImplementations<cr>', 'Find implementations')

      -- Code actions
      map('n', '<leader>ca', '<cmd>TSToolsCodeActions<cr>', 'Code actions')
      map('n', '<leader>cr', '<cmd>TSToolsRenameFile<cr>', 'Rename file')
      map('n', '<leader>cA', '<cmd>TSToolsAddMissingImports<cr>', 'Add missing imports')
      map('n', '<leader>cu', '<cmd>TSToolsRemoveUnused<cr>', 'Remove unused imports')
      map('n', '<leader>co', '<cmd>TSToolsOrganizeImports<cr>', 'Organize imports')
      map('n', '<leader>cf', '<cmd>TSToolsFixAll<cr>', 'Fix all auto-fixable issues')
      map('n', '<leader>cR', '<cmd>TSToolsRemoveUnusedImports<cr>', 'Remove unused imports')

      -- Type information
      map('n', '<leader>ct', '<cmd>TSToolsTypeDefinition<cr>', 'Type definition')
      map('n', '<leader>cd', '<cmd>TSToolsGoToSourceDefinition<cr>', 'Go to source definition')
    end,
    settings = {
      tsserver_path = '', -- Leave empty to use default path
      -- expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
      complete_function_calls = true,
      include_completions_with_insert_text = true,
      -- Other settings you might want to configure:
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      tsserver_format_options = {
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterConstructor = false,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        insertSpaceBeforeFunctionParenthesis = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
        insertSpaceAfterTypeAssertion = false,
        placeOpenBraceOnNewLineForFunctions = false,
        placeOpenBraceOnNewLineForControlBlocks = false,
      },
    },
    handlers = {
      -- Custom handlers can be added here
    },
  },
  config = function(_, opts)
    require('typescript-tools').setup(opts)
  end,
}
