local M = {
  -- { "folke/tokyonight.nvim",         lazy = false, priority = 1000 },
  -- { "Mofiqul/dracula.nvim",          lazy = false, priority = 1000 },
  -- { "savq/melange-nvim",             lazy = false, priority = 1000 },
  -- { "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000, },
  -- { "mhartington/oceanic-next",      lazy = false, priority = 1000 },
  -- { "rose-pine/neovim",              lazy = false, priority = 1000, },
  -- { "zenbones-theme/zenbones.nvim",  lazy = false, priority = 1000, dependencies = "rktjmp/lush.nvim", },
  -- { "EdenEast/nightfox.nvim",        lazy = false, priority = 1000, },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "hard"
      vim.cmd.colorscheme('everforest')
    end
  },
}


return M
