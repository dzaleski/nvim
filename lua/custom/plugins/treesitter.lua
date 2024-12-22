return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
  },
  {
    'dlvandenberg/tree-sitter-angular',
    run = ':TSUpdate',
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ts_utils' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function()
      local function copy_json_path()
        local bufnr = vim.api.nvim_get_current_buf()
        local params = vim.lsp.util.make_position_params()
        local result = {}

        vim.lsp.buf_request(bufnr, 'textDocument/documentSymbol', params, function(err, _, response)
          if err or not response then
            print 'No JSON key found under cursor!'
            return
          end

          local function find_path(symbols, path)
            for _, symbol in ipairs(symbols) do
              if symbol.kind == 5 then -- 5 corresponds to LSP's Constant kind (used for JSON keys)
                local range = symbol.selectionRange
                if
                  range.start.line <= params.position.line
                  and range['end'].line >= params.position.line
                  and range.start.character <= params.position.character
                  and range['end'].character >= params.position.character
                then
                  table.insert(path, symbol.name)
                  if symbol.children then
                    find_path(symbol.children, path)
                  end
                  break
                end
              end
            end
          end

          find_path(response, result)

          if #result > 0 then
            local json_path = "'" .. table.concat(result, '.') .. "'"
            vim.fn.setreg('+', json_path)
            print('Copied JSON path: ' .. json_path)
          else
            print 'No JSON key found under cursor!'
          end
        end)
      end

      vim.keymap.set('n', '<leader>cjp', copy_json_path, { desc = 'Copy JSON path to clipboard' })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
