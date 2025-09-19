vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/folke/lazydev.nvim"
})

require("mason").setup({})

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.lsp.config('copilot', {
  cmd = { 'copilot-language-server', '--stdio', },
  root_markers = { '.git' },
})
vim.lsp.enable('copilot')
vim.lsp.inline_completion.enable()

vim.keymap.set('i', '<C-CR>', vim.lsp.inline_completion.get, { desc = 'Accept LSP inline suggestion' })

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
  lspconfig[server].setup({
    on_attach = nil,
  })
end
