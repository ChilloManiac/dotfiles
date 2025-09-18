vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/shortcuts/no-neck-pain.nvim",
})

require('which-key').setup({})
require('no-neck-pain').setup({
  width = 200,
})

vim.keymap.set('n', '<leader>nn', ":NoNeckPain<CR>", { desc = "Toggle No Neck Pain" })
