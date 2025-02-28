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
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 4
vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 4
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.winwidth = 120
vim.opt.winminwidth = 30
vim.opt.background = "dark"

function FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  return line .. " "
end

vim.o.foldtext = "v:lua.FoldText()"

vim.g.is_github_cli = vim.fn.environ()["IS_GH_CLI"] == "1"

--------------------------------------------------------------------------
-- Key maps
--------------------------------------------------------------------------
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
vim.keymap.set("n", "<leader>sf", ":source %<CR>", { noremap = true, desc = "Source current file" })

vim.keymap.set("i", "jj", "<esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "KK", "<esc>>>A", { noremap = true, desc = "Indent line and append" })
vim.keymap.set("i", "HH", "<esc><<A", { noremap = true, desc = "Unindent line and append" })

vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, desc = "Quit" })


--- terminal
local terminal = require("custom.terminal")
vim.keymap.set("n", "<leader>tt", terminal.toggle_term, { noremap = true, desc = "Toggle terminal" })

vim.keymap.set("n", "<leader>TT", terminal.new_term, { noremap = true, desc = "New terminal" })

vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal mode" })
vim.keymap.set("t", "jj", terminal.toggle_term, { noremap = true, desc = "Toggle term" })
