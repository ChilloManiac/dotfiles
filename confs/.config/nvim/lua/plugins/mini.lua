vim.pack.add({
  "https://github.com/echasnovski/mini.nvim",
})

require('mini.icons').setup()
require("mini.extra").setup()
require('mini.ai').setup()
require("mini.align").setup()
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.notify").setup()

-- Picker
local win_config = function()
  -- Taken from mini.pick documentation
  local height = math.floor(0.618 * vim.o.lines)
  local width = math.floor(0.618 * vim.o.columns)
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end
require("mini.pick").setup({ window = { config = win_config }, mappings = { choose_marked = "<C-CR>" } })
vim.ui.select = require("mini.pick").ui_select
vim.keymap.set('n', '<leader>rg', ":Pick grep_live<CR>", { desc = "Grep" })
vim.keymap.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', ":Pick git_files<CR>", { desc = "Find Git files" })
vim.keymap.set('n', '<leader>fh', ":Pick help<CR>", { desc = "Find Help" })
vim.keymap.set('n', '<leader>tr', ":Pick resume<CR>", { desc = "Resume" })
vim.keymap.set('n', '<leader>fr', ":Pick oldfiles<CR>", { desc = "Find Recent files" })
vim.keymap.set('n', '<leader>ve',
  function() require("mini.pick").builtin.files(nil, { source = { cwd = "~/.config/nvim" } }) end,
  { desc = "Edit vim config" })
