vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")
lint.linters_by_ft = {
  markdown = { "markdownlint" },
  python = { "flake8" },
  lua = { "luacheck" },
  typescript = {},
  javascript = {},
  go = { "revive" }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
