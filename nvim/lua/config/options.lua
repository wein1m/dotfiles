local opt = vim.opt

-- Tab / Spaces
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Clipboard
opt.clipboard = "unnamed" -- use system clipboard as default register

-- Display
vim.o.relativenumber = true
opt.number = true
opt.jumpoptions = "stack,view"
vim.keymap.set('n', '<leader>to', function() opt.scrolloff = 999 - vim.o.scrolloff end)
opt.listchars = { tab = "-->", multispace = "·", trail = "", extends = "⟩", precedes = "⟨" }

-- Others
opt.undofile = true
opt.incsearch = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive
