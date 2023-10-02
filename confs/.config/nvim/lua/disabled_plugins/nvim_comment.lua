local M = {
  'terrortylor/nvim-comment',
  event = "BufEnter",
  keys = {
    { "<C-/>", "<cmd>CommentToggle<cr>", desc = "Comment" },
  },
  opts = {}
}

return M
