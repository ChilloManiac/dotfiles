-- Enable syntax highlighting
vim.cmd("syntax on")

-- Disable the GUI cursor
vim.opt.guicursor = ""

-- Disable highlighting the current matching parentheses or bracket
vim.opt.showmatch = false

-- Use relative line numbering
vim.opt.relativenumber = true

-- Enable hidden buffers
vim.opt.hidden = true

-- Disable error bells
vim.opt.errorbells = false

-- Set the width of a tab to 2 spaces and enable automatic indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable line numbering
vim.opt.number = true

-- Disable line wrapping
vim.opt.wrap = false

-- Enable smart case sensitivity
vim.opt.smartcase = true

-- Disable swap files and backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Set the directory where undo files are stored and enable undo persistence
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true

-- Enable incremental search
vim.opt.incsearch = true

-- Enable true color support in the terminal
vim.opt.termguicolors = true

-- Set the number of lines to keep visible above and below the cursor
vim.opt.scrolloff = 8

-- Hide the mode indicator in the command line
vim.opt.showmode = false

-- Set the options for text completion
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

-- Set the default shell to Bash
vim.opt.shell = "/bin/bash"

-- Give more space for displaying messages
vim.opt.cmdheight = 2

-- Reduce the updatetime to 50ms to reduce lag
vim.opt.updatetime = 50

-- Don't show messages in the completion menu
vim.opt.shortmess:append("c")
