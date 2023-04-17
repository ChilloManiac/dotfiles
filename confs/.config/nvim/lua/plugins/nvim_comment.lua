local M = {
  'terrortylor/nvim-comment',
  config = function()
    require('nvim_comment').setup({
      line_mapping = "<C-/>",
      operator_mapping = "<C-/>"
    })
  end
}

return M
