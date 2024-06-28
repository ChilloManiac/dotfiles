--------------------------------------------------------------------------
-- General settings
----------------------------------------------------------------------------
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes:2"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spell = false
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true
vim.opt.updatetime = 300
vim.opt.redrawtime = 10000
vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false

--------------------------------------------------------------------------
-- Key maps
--------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.api.nvim_set_keymap("n", "<leader>k", ":nohlsearch<CR>", { noremap = true })

vim.api.nvim_set_keymap("v", "y", "myy`y", { noremap = true })
vim.api.nvim_set_keymap("v", "Y", "myY`y", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>p", "\"_dP", { noremap = true })

vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w", "<C-w>", { noremap = true })

vim.api.nvim_set_keymap("i", "jj", "<esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "KK", "<esc>>>A", { noremap = true })
vim.api.nvim_set_keymap("i", "HH", "<esc><<A", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })
