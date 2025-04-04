-- Visual mode mappingske
vim.keymap.set('v', '<Leader>u', '"+p', { desc = 'Pick and paste from clipboard manager' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', '<Leader>l', '$', { desc = 'Move to end of line' })
vim.keymap.set('v', '<Leader>h', '^', { desc = 'Move to start of line' })
-- vim.keymap.set('v', 'J', '5j', { desc = 'Move down 5 lines' })
-- vim.keymap.set('v', 'K', '5k', { desc = 'Move up 5 lines' })
vim.keymap.set('v', '<', '<gv', { desc = 'Outdent and stay in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and stay in visual mode' })

-- Normal mode mappings
vim.keymap.set('n', 'gd', 'gdzt', { desc = 'Go to definition and center screen' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center screen' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center screen' })
vim.keymap.set('n', '>', '>>', { desc = 'Indent current line' })
vim.keymap.set('n', '<', '<<', { desc = 'Outdent current line' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up and center screen' })
vim.keymap.set('n', '<D-u>', '<C-u>zz', { desc = 'Page up and center screen' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down and center screen' })
vim.keymap.set('n', '<D-d>', '<C-d>zz', { desc = 'Page down and center screen' })
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<D-a>', 'ggVG', { desc = 'Select all' }) -- CMD + a for MacOS
vim.keymap.set('n', '<Leader>l', '$', { desc = 'Move to end of line' })
vim.keymap.set('n', '<Leader>h', '^', { desc = 'Move to start of line' })
vim.keymap.set('n', '<Leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<Leader>q', ':bd<CR>', { desc = 'Close active buffer' })
vim.keymap.set('n', '<Leader>Q', ':e #<CR>', { desc = 'Reopen last closed buffer' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<D-h>', '<C-w>h', { desc = 'Move to left window Macos' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<D-l>', '<C-w>l', { desc = 'Move to right window Macos' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
vim.keymap.set('n', '<D-j>', '<C-w>j', { desc = 'Move to below window Macos' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
vim.keymap.set('n', '<D-k>', '<C-w>k', { desc = 'Move to above window Macos' })
--
-- vim.keymap.set('n', '<C-j>', 'g;zz', { desc = 'Jump to the previous edit location' })
-- vim.keymap.set('n', '<D-j>', 'g;zz', { desc = 'Jump to the previous edit location Macos' })
-- vim.keymap.set('n', '<C-h>', 'g,zz', { desc = 'Jump to the next edit location' })
-- vim.keymap.set('n', '<D-h>', 'g,zz', { desc = 'Jump to the next edit location Macos' })
--
--
--
--something haha
