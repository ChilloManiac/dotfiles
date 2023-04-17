local M = {
  "Mofiqul/dracula.nvim",
  config = function()
    require("dracula").setup()
    vim.cmd("colorscheme dracula")
  end
}

return M
