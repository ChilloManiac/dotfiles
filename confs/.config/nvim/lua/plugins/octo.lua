local M = {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {'<leader>ocpl', '<cmd>Octo pr list<cr>', desc = 'List pull requests' },
    {'<leader>ocpc', '<cmd>Octo pr create<cr>', desc = 'Create pull request' },
    {'<leader>ocpu', '<cmd>Octo pr url<cr>', desc = 'Copy pull request url' },
    {'<leader>ocpr', '<cmd>Octo pr reload<cr>', desc = 'Reload pull request' },
    {'<leader>ocpm', '<cmd>Octo pr merge rebase<cr>', desc = 'Merge pr with rebase' },
    {'<leader>ocla', '<cmd>Octo label add<cr>', desc = 'Add Label' },
  }
}

M.config = function()
  require('octo').setup({
    mappings = {
      pull_request = {
        add_comment = { lhs = "<leader>occa"},
        delete_comment = { lhs = "<leader>occd"},
      },
      review_diff = {
        add_review_comment = { lhs = "<leader>occa" },
        add_review_suggestion = { lhs = "<leader>occs" },
      }
    }
  })
end

return M
