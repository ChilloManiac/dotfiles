local leet_arg = "leetcode.nvim"

local M = {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  lazy = leet_arg ~= vim.fn.argv()[1],
  opts = {
    arg = leet_arg,
    lang = 'elixir'
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
}

M.config = function(_, opts)
  require('leetcode').setup(opts)
  vim.keymap.set("n", "<leader>lct", "<cmd>Leet test<cr>")
  vim.keymap.set("n", "<leader>lcs", "<cmd>Leet submit<cr>")
  vim.keymap.set("n", "<leader>lcl", "<cmd>Leet<cr>")
end


return M
