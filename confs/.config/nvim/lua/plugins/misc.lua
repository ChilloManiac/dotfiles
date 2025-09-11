vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/shortcuts/no-neck-pain.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/kylechui/nvim-surround",
})

require('which-key').setup({})
require('no-neck-pain').setup({
  width = 200,
})
require('nvim-autopairs').setup({
  disable_filetype = { "markdown" }
})
require('nvim-surround').setup({})
