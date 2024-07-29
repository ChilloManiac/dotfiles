local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,          -- false will disable the whole extension
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    -- vim.opt.foldmethod = "expr"
  end,
}

return M
