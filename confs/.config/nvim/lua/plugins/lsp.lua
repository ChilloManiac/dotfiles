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
