vim.pack.add({
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
})

require("diffview").setup()
require("gitsigns").setup()

vim.keymap.set("n", "<leader>dd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview Open" })
vim.keymap.set("n", "<leader>dm", "<cmd>DiffviewOpen main<CR>", { desc = "Diffview Open main" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Diffview Close" })
