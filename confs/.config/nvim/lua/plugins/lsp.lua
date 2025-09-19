vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/folke/lazydev.nvim"
})

require("mason").setup({})

vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.lsp.inline_completion.enable()


local default_setup_lsps = {
  "bashls",
  "biome",
  "cssls",
  "dockerls",
  "elixirls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "powershell_es",
  "pyright",
  "sqlls",
  "terraformls",
  "tflint",
  "vimls",
  "vtsls",
  "yamlls",
}

for _, server in ipairs(default_setup_lsps) do
  vim.lsp.enable(server)
end

-- Copilot support

vim.lsp.config('copilot', {
  cmd = { 'copilot-language-server', '--stdio', },
  root_markers = { '.git' },
})
vim.lsp.enable('copilot')

vim.keymap.set('i', '<C-CR>', vim.lsp.inline_completion.get, { desc = 'Accept LSP inline suggestion' })
