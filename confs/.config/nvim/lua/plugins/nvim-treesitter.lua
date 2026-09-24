vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/aaronik/treewalker.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})


vim.keymap.set("n", "+", "v", { noremap = true, silent = true })

local treesitter = require("nvim-treesitter")

local langs = { "json", "lua", "go", "markdown", "html", "latex", "yaml", "javascript" }
local additional = { "comment", "markdown_inline", "diff" }

treesitter.install(langs)
treesitter.install(additional)
treesitter.update()


vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("treesitter-setup", {}),
  pattern = langs,
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})


require('treewalker').setup({
  highlight = false
})
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>zz', { silent = true, desc = "Move up in Treewalker" })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>zz',
  { silent = true, desc = "Move down in Treewalker" })
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>zz',
  { silent = true, desc = "Move right in Treewalker" })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>zz',
  { silent = true, desc = "Move left in Treewalker" })

vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>zz',
  { silent = true, desc = "Swap down in Treewalker" })
vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>zz', { silent = true, desc = "Swap up in Treewalker" })
vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<CR>zz',
  { silent = true, desc = "Swap right in Treewalker" })
vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<CR>zz',
  { silent = true, desc = "Swap left in Treewalker" })

require("treesitter-context").setup({
  max_lines = 4
})
