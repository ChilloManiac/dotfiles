local M = {
  { "folke/tokyonight.nvim", lazy = true },
  { "Mofiqul/dracula.nvim",  lazy = true },
  { "savq/melange-nvim",     lazy = true },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rose-pine-moon")
    end
  },
}

return M
