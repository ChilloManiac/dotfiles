local M = {
  { "folke/tokyonight.nvim", lazy = true },
  { "Mofiqul/dracula.nvim",  lazy = true },
  { "savq/melange-nvim",     lazy = true },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme cyberdream")
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
}

return M
