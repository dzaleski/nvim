return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'typescript',
        'css',
        'json',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
  },
  {
    'dlvandenberg/tree-sitter-angular',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        sync_install = false,
        modules = {},
        auto_install = true,
        ignore_install = {},
        ensure_installed = { 'angular' },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
    end,
  },
}
