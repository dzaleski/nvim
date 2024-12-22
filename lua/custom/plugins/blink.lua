return {
  'saghen/blink.cmp',
  version = not vim.g.lazyvim_blink_main and '*',
  build = vim.g.lazyvim_blink_main and 'cargo build --release',
  opts_extend = {
    'sources.completion.enabled_providers',
    'sources.compat',
    'sources.default',
  },
  dependencies = {
    -- 'rafamadriz/friendly-snippets',
    {
      'saghen/blink.compat',
      optional = true,
      opts = {},
      version = not vim.g.lazyvim_blink_main and '*',
    },
  },
  event = 'InsertEnter',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
        border = CUSTOM_BORDER,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    signature = { enabled = false },
    sources = {
      compat = {},
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      cmdline = {},
    },
    keymap = {
      preset = 'enter',
      ['<C-j>'] = { 'select_next' },
      ['<D-j>'] = { 'select_next' },
      ['<C-k>'] = { 'select_prev' },
      ['<D-k>'] = { 'select_prev' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<D-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<D-e>'] = { 'hide' },
      ['<C-u>'] = { 'scroll_documentation_up' },
      ['<D-u>'] = { 'scroll_documentation_up' },
      ['<C-d>'] = { 'scroll_documentation_down' },
      ['<D-d>'] = { 'scroll_documentation_down' },
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend('force', { name = source, module = 'blink.compat.source' }, opts.sources.providers[source] or {})
      if type(enabled) == 'table' and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    opts.sources.compat = nil

    for _, provider in pairs(opts.sources.providers or {}) do
      local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
      local kind_idx = #CompletionItemKind + 1

      CompletionItemKind[kind_idx] = provider.kind
      ---@diagnostic disable-next-line: no-unknown
      CompletionItemKind[provider.kind] = kind_idx

      local transform_items = provider.transform_items
      provider.transform_items = function(ctx, items)
        items = transform_items and transform_items(ctx, items) or items
        for _, item in ipairs(items) do
          item.kind = kind_idx or item.kind
        end
        return items
      end

      provider.kind = nil
    end

    require('blink.cmp').setup(opts)
  end,
}
