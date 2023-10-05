local M = {
  { "folke/tokyonight.nvim", lazy = true },
  { "Mofiqul/dracula.nvim", lazy = true },
  {
    "savq/melange-nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme melange")
    end
  }
}

return M
