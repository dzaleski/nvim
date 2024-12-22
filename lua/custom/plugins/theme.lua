vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'sonokai', -- Only triggers for Sonokai
  callback = function()
    -- 1. Set custom highlights (Sonokai Espresso contrast)
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = '#ff5189', bg = '#3a2a32' })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = '#ffd866', bg = '#3a322a' })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = '#78dce8', bg = '#2a3a3a' })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = '#a9dc76', bg = '#2a3a2a' })

    -- 2. Apply diagnostic config (same as before)
    vim.diagnostic.config {
      virtual_text = {
        spacing = 4,
        prefix = '●',
        severity = { min = vim.diagnostic.severity.HINT },
        hl_mode = 'combine',
      },
    }
  end,
})

return {
  {
    'sainnhe/sonokai',
    priority = 1000, -- Load early to set the colorscheme
    opts = {},
    enabled = true,
    config = function()
      vim.g.sonokai_style = 'espresso'
      vim.g.sonokai_enable_italic = 1 -- Enable italic (optional)
      vim.g.sonokai_disable_italic_comment = 1 -- Disable italic in comments (optional)
      vim.g.sonokai_transparent_background = 0 -- Set to 1 for transparent background
      vim.g.sonokai_better_performance = 1 -- Better performance ()

      vim.o.background = 'dark' -- Ensure the background is set to dark
      vim.cmd [[colorscheme sonokai]]
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Load early to set the colorscheme
    opts = {},
    enabled = false,
    config = function()
      vim.g.tokyonight_style = 'night' -- Set to 'night' or 'day' depending on preference
      vim.g.tokyonight_italic_comments = true -- Enable italic in comments (optional)
      vim.g.tokyonight_italic_keywords = true -- Enable italic in keywords (optional)
      vim.g.tokyonight_transparent_background = false -- Set to true for transparent background
      vim.g.tokyonight_hide_inactive_statusline = true -- Hide inactive statusline

      vim.o.background = 'dark' -- Ensure the background is set to dark
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    'tiagovla/tokyodark.nvim',
    opts = {
      -- custom options here
    },
    enabled = false,
    config = function(_, opts)
      require('tokyodark').setup {
        transparent_background = false, -- set background to transparent
        gamma = 1.00, -- adjust the brightness of the theme
        styles = {
          comments = { italic = true }, -- style for comments
          keywords = { italic = true }, -- style for keywords
          identifiers = { italic = true }, -- style for identifiers
          functions = {}, -- style for functions
          variables = {}, -- style for variables
        },
        terminal_colors = true,
        custom_highlights = {} or function(highlights, palette)
          return {}
        end, -- extend highlights
        custom_palette = {} or function(palette)
          return {}
        end, -- extend palette
      }
      vim.cmd [[colorscheme tokyodark]]
    end,
  },
}
