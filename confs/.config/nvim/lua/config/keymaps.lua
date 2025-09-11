vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>k", ":nohlsearch<CR>", { noremap = true, desc = "Clear search highlight" })

vim.keymap.set("v", "<leader>p", "\"_dP", { noremap = true, desc = "Paste without overwriting register" })

vim.keymap.set("n", "n", "nzzzv", { noremap = true, desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, desc = "Previous search result and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zzzv", { noremap = true, desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zzzv", { noremap = true, desc = "Scroll up and center" })
vim.keymap.set("n", "<leader>w", "<C-w>", { noremap = true, desc = "Window commands" })
vim.keymap.set("n", "z1", ":set foldlevel=1<CR>", { noremap = true, desc = "Set fold level to 1" })
vim.keymap.set("n", "z2", ":set foldlevel=2<CR>", { noremap = true, desc = "Set fold level to 2" })
vim.keymap.set("n", "<leader>sf", ":source %<CR>", { noremap = true, desc = "Source current file" })

vim.keymap.set("i", "jj", "<esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, desc = "Quit" })

vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition()<cr>", { remap = false })
vim.keymap.set("n", "<leader>fb", "<cmd>lua vim.lsp.buf.format()<cr>", { remap = false })
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", { remap = false })
