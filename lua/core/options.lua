-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- FiraCode Nerd Font:h14
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.treesitter.language.register('angular', 'angular.html')
vim.treesitter.language.register('markdown', 'mdx')
vim.treesitter.language.register('markdown', 'agx')
vim.treesitter.language.register('markdown', 'svx')
vim.treesitter.language.register('vue', 'analog')
vim.treesitter.language.register('vue', 'ag')
vim.treesitter.language.register('vue', 'agx')
vim.treesitter.language.register('json', '.all-contributorsrc')

-- Neovide configuration
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.06
  vim.g.neovide_cursor_trail_size = 0.24
  vim.g.neovide_scroll_animation_length = 0.15
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_fullscreen = true
end

-- Configure visual appearance of diff views
vim.opt.fillchars = {
  diff = '╱', -- Use slanted lines (╱) for diff filler characters
  -- Creates a distinctive visual separation in diff hunks
}

-- Configure diff behavior options:
vim.opt.diffopt = {
  'internal', -- Use Neovim's built-in diff (not external tools)
  'filler', -- Show filler lines for alignment
  'closeoff', -- Hide unchanged portions when folds are closed
  'context:8', -- Show 12 lines of context around changes
  'algorithm:histogram', -- Use histogram algorithm for better diffs
  'linematch:200', -- Enable improved line matching for up to 200 lines
  'indent-heuristic', -- Use indentation heuristics for better matching
}
