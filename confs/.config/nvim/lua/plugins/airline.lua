local M = {
  'vim-airline/vim-airline',
  depends = 'vim-airline/vim-airline-themes',
  config = function ()
    vim.g.airline_theme = 'dracula'
    vim.g.airline_powerline_fonts = 1
  end
}

return M
