local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  event = "VeryLazy" -- Need to load it for the ui-select
}



M.config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      },
      ["fzf"] = {},
      ["dap"] = {},
    },
    pickers = {
      git_branches = {
        mappings = {
          i = { ["<cr>"] = actions.git_switch_branch }
        }
      }
    }
  })

  telescope.load_extension('ui-select')
  telescope.load_extension('fzf')

  local custom_pickers = require('custom.telescope-pickers')

  vim.keymap.set('n', '<leader>rg', custom_pickers.filter_grep, { noremap = true, silent = true, desc = "Filter Grep" })
  vim.keymap.set('n', '<leader>cd', custom_pickers.zoxide_cd,
    { noremap = true, silent = true, desc = "Change Directory" })
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>',
    { noremap = true, silent = true, desc = "Find Files" })
  vim.keymap.set('n', '<leader>fc', '<cmd>Telescope git_status<cr>',
    { noremap = true, silent = true, desc = "Find Changed Files" })
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_files<cr>',
    { noremap = true, silent = true, desc = "Find Git Files" })
  vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>',
    { noremap = true, silent = true, desc = "Find Help" })
  vim.keymap.set('n', '<leader>tr', '<cmd>Telescope resume<cr>',
    { noremap = true, silent = true, desc = "Telescope Resume" })
  vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>',
    { noremap = true, silent = true, desc = "Find Recent files" })
  vim.keymap.set('n', '<leader>ve', '<cmd>Telescope find_files cwd=~/.config/nvim<CR>',
    { noremap = true, silent = true, desc = "Edit vim config" })
end

return M
