local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'debugloop/telescope-undo.nvim' },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = "Find Files" },
    { '<leader>fg', '<cmd>Telescope git_files<cr>',              desc = "Find Git Files" },
    { '<leader>rg', '<cmd>Telescope live_grep hidden=true<cr>',  desc = "Grep" },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',                desc = "Buffers" },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',              desc = "Find Help" },
    { '<leader>fu', '<cmd>Telescope undo<cr>',                   desc = "Undo" },
  }
}

M.config = function()
  local telescope = require('telescope')

  telescope.setup({
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      },
      ["fzf"] = {},
      ["dap"] = {},
      ["undo"] = {},
    }
  })

  require('nvim-web-devicons').setup()
  telescope.load_extension('ui-select')
  telescope.load_extension('fzf')
  telescope.load_extension('undo')
end

return M
