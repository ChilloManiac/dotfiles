local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  build = ":TSUpdate:",
  ---@type TSConfig
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
  ---@param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldmethod = "expr"
    local treesitter_au = vim.api.nvim_create_augroup("treesitter_au", { clear = true })

    print("treesitter_au", treesitter_au)
    vim.api.nvim_create_autocmd("BufReadPost,FileReadPost", {
      pattern = "*",
      callback = function()
        vim.cmd("normal zx")
        vim.cmd("normal zR")
      end,
      group = treesitter_au,
    })
  end,
}

return M
