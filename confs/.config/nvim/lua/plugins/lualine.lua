local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { {'nvim-tree/nvim-web-devicons'}, {"folke/tokyonight.nvim"} },
  config = function()
    require('lualine').setup({
      theme = 'tokyonight',
      sections = {
        lualine_x = {'overseer'}
      }
    })
  end
}

return M
