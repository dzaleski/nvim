return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000, -- Load early to set the colorscheme
    opts = {},
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_enable_italic = 1 -- Enable italic for better syntax highlighting (optional)
      vim.g.gruvbox_material_enable_bold = 1 -- Enable bold fonts (optional)
      vim.o.background = 'dark' -- Ensure the background is set to dark
      vim.cmd [[colorscheme gruvbox-material]]
    end,
  },
}
