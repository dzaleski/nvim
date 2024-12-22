local function map(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- VISUAL MODE MAPPINGS
-- Movement
map('v', 'K', ":m '<-2<CR>gv=gv", 'Move selected lines up')
map('v', 'J', ":m '>+1<CR>gv=gv", 'Move selected lines down')
map('v', '<Leader>l', '$', 'Move to end of line')
map('v', '<Leader>h', '^', 'Move to start of line')

-- Indentation
map('v', '<', '<gv', 'Outdent and stay in visual mode')
map('v', '>', '>gv', 'Indent and stay in visual mode')

-- NORMAL MODE MAPPINGS
-- Navigation
map('n', 'gd', 'gdzt', 'Go to definition and center screen')
map('n', 'n', 'nzzzv', 'Next search result and center screen')
map('n', 'N', 'Nzzzv', 'Previous search result and center screen')
map('n', '<C-u>', '<C-u>zz', 'Page up and center screen')
map('n', '<D-u>', '<C-u>zz', 'Page up and center screen')
map('n', '<C-d>', '<C-d>zz', 'Page down and center screen')
map('n', '<D-d>', '<C-d>zz', 'Page down and center screen')
map('n', '<Leader>l', '$', 'Move to end of line')
map('n', '<Leader>h', '^', 'Move to start of line')

-- Buffer management
map('n', '<Leader>w', ':w<CR>', 'Save file')
map('n', '<Leader>q', ':bd<CR>', 'Close active buffer')
map('n', '<Leader>Q', ':e #<CR>', 'Reopen last closed buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Go to previous buffer')
map('n', '<S-l>', ':bnext<CR>', 'Go to next buffer')

-- Editing
map('n', '<C-a>', 'ggVG', 'Select all')
map('n', '<D-a>', 'ggVG', 'Select all (macOS)')
map('n', '>', '>>', 'Indent current line')
map('n', '<', '<<', 'Outdent current line')
map('n', 'U', '<C-r>', 'Redo')
map('n', '<Leader>r', vim.lsp.buf.rename, 'Rename symbol')

-- Diagnostics
map('n', ']e', vim.diagnostic.goto_next, 'Next diagnostic')
map('n', '[e', vim.diagnostic.goto_prev, 'Previous diagnostic')

-- UI
map('n', '<Esc>', '<cmd>nohlsearch<CR>', 'Clear search highlight')

-- Remember position before counted jumps (e.g. 12j) to allow returning with Ctrl-o
vim.keymap.set('n', 'j', function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. 'j'
  end
  return 'j'
end, { expr = true })

vim.keymap.set('n', 'k', function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. 'k'
  end
  return 'k'
end, { expr = true })
