local M = {
  "numToStr/FTerm.nvim",
  keys = {
    { "<F12>", '<CMD>lua require("FTerm").toggle()<CR>' },
  },
  opts = {
    border = "single",
    dimensions = {
      height = 0.8,
      width = 0.8,
    },
  },
}

M.config = function(_, opts)
  require("FTerm").setup(opts)

  vim.keymap.set("n", "<F12>", '<CMD>lua require("FTerm").toggle()<CR>')
  vim.keymap.set("t", "<F12>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
end

return M
