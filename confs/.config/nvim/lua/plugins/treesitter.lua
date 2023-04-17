local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  build = ":TSUpdate:",
  ---@type TSConfig
  opts = {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true, -- false will disable the whole extension
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

  ---@param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return M
