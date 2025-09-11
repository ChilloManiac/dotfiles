vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})


vim.keymap.set("n",
  "<leader>fdb",
  function()
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    if vim.b.disable_autoformat then return vim.notify("Disabled autoformat for buffer") end
    vim.notify("Enabled autoformat for buffer")
  end,
  { desc = "Toggle disable autoformat for buffer" }
)

vim.keymap.set("n",
  "<leader>fdd",
  function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    if vim.g.disable_autoformat then return vim.notify("Disabled autoformat for all buffers") end
    vim.notify("Enabled autoformat for all buffers")
  end,
  { desc = "Toggle disable autoformat for all buffers" }
)

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    terraform = { "terraform_fmt" },
    typescript = { "biome", "biome-check", },
    javascript = { "biome", "biome-check" },
    javascriptreact = { "biome", "biome-check" },
    typescriptreact = { "biome", "biome-check" },
    sql = { "sqlfluff" },
    markdown = { "prettier" },
    go = { "gofmt" },
    yaml = { "prettier" },
    bash = { "shfmt" },
    shell = { "shfmt" },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return { timeout_ms = 1000, lsp_fallback = true }
  end,
})
