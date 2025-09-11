vim.pack.add({
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
})

vim.keymap.set("n", "<leader>dbui", "<cmd>DBUIToggle<CR>", { desc = "DBUI Toggle" })
vim.g.db_ui_use_nerd_fonts = 1
