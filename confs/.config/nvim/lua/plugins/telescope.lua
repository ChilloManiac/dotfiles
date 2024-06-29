local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  lazy = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'debugloop/telescope-undo.nvim' },
    { 'nvim-telescope/telescope-project.nvim' },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>',        desc = "Find Files" },
    { '<leader>fg', '<cmd>Telescope git_files<cr>',                     desc = "Find Git Files" },
    { '<leader>gb', '<cmd>Telescope git_branches<cr>',                  desc = "Find Git Branches" },
    { '<leader>rg', '<cmd>Telescope live_grep hidden=true<cr>',         desc = "Grep" },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',                     desc = "Find Help" },
    { '<leader>fu', '<cmd>Telescope undo<cr>',                          desc = "Undo" },
    { '<leader>tr', '<cmd>Telescope resume<cr>',                        desc = "Telescope Resume" },
    { '<leader>fp', '<cmd>Telescope project<cr>',                       desc = "Find Projects" },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                      desc = "Find Recent files" },
    { '<leader>ve', '<cmd>Telescope find_files cwd=~/.config/nvim<CR>', desc = "Edit vim config" }
  },
}

M.config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      preview = false,
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      },
      ["fzf"] = {},
      ["dap"] = {},
      ["undo"] = {},
    },
    pickers = {
      git_branches = {
        mappings = {
          i = { ["<cr>"] = actions.git_switch_branch }
        }
      }
    }
  })

  require('nvim-web-devicons').setup()
  telescope.load_extension('ui-select')
  telescope.load_extension('fzf')
  telescope.load_extension('undo')
  telescope.load_extension('project')
end

return M
