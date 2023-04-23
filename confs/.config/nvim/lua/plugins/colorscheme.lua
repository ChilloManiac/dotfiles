-- local M = {
--   "Mofiqul/dracula.nvim",
--   config = function()
--     require("dracula").setup()
--     vim.cmd("colorscheme dracula")
--   end
-- }

local M = {
  "folke/tokyonight.nvim",
  config = function()
    vim.cmd("colorscheme tokyonight-night")
  end
}

return M
