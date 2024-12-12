local M = {
  { "folke/tokyonight.nvim",         lazy = true, priority = 1000 },
  { "Mofiqul/dracula.nvim",          lazy = true, priority = 1000 },
  { "savq/melange-nvim",             lazy = true, priority = 1000 },
  { "scottmckendry/cyberdream.nvim", lazy = true, priority = 1000, },
  { "mhartington/oceanic-next",      lazy = true, priority = 1000 },
  { "rose-pine/neovim",              lazy = true, priority = 1000, },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme terafox")
    end
  },
}


return M
