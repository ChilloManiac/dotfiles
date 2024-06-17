local M = {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<Leader>gd', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diff File' },
    { '<Leader>gv', '<cmd>DiffviewOpen<CR>',          desc = 'Diff View' },
  },
}

return M
