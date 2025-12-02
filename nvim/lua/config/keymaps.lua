vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Highlight all words under cursor
vim.keymap.set('n', '<leader>hw', ':let @/=expand("<cword>")<CR>:set hlsearch<CR>')

-- Insert line above in Insert mode ( same as shift + o when in normal mode )
vim.keymap.set("i", "<leader>ko", "<Esc>O", { noremap = true, silent = true })

-- Navigate between windows using Ctrl + arrow keys
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Use this for navigation in terminal mode
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]])

-- Enter normal mode in a terminal buffer.
vim.keymap.set('t', '<C-u>', '<C-\\><C-n>')

-- Exit terminal buffer
vim.keymap.set('t', '<Esc>', '<Cmd>q!<CR>')

-- Make all windows equal size
vim.keymap.set('n', '<leader>rw', '<C-W>=')

-- Make the cursor fixed at the center
vim.keymap.set('n', '<leader>to', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end)
