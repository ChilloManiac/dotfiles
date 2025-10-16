vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/Mofiqul/dracula.nvim",
  "https://github.com/savq/melange-nvim",
  "https://github.com/scottmckendry/cyberdream.nvim",
  "https://github.com/mhartington/oceanic-next",
  "https://github.com/rose-pine/neovim",
  "https://github.com/zenbones-theme/zenbones.nvim",
  "https://github.com/rktjmp/lush.nvim",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/sainnhe/everforest",
  "https://github.com/rebelot/kanagawa.nvim"
})

vim.g.everforest_enable_italic = true
vim.g.everforest_background = "hard"

local kanagawa = require("kanagawa")
kanagawa.load()
local kana_colors = require("kanagawa.colors").setup()
kanagawa.setup({
  compile = true,
  transparent = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
          bg_visual = kana_colors.palette.waveAqua1
        }
      }
    }
  }
})

vim.cmd.colorscheme('kanagawa-wave')
