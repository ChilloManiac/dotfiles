local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>',        desc = "Find Files" },
    { '<leader>fg', '<cmd>Telescope git_files<cr>',                     desc = "Find Git Files" },
    { '<leader>gb', '<cmd>Telescope git_branches<cr>',                  desc = "Find Git Branches" },
    { '<leader>rg', '<cmd>Telescope live_grep hidden=true<cr>',         desc = "Grep" },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',                     desc = "Find Help" },
    { '<leader>tr', '<cmd>Telescope resume<cr>',                        desc = "Telescope Resume" },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                      desc = "Find Recent files" },
    { '<leader>ve', '<cmd>Telescope find_files cwd=~/.config/nvim<CR>', desc = "Edit vim config" }
  },
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
end

return M
