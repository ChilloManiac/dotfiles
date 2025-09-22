vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/folke/lazydev.nvim"
})

require("mason").setup({})
require("lazydev").setup({})

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
local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {})

local set_lsp_folding = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end
  if client:supports_method('textDocument/foldingRange') then
    vim.notify("LSP folding enabled", vim.log.levels.INFO)
    vim.b[args.buf].foldexpr = "v:lua.vim.lsp.foldexpr()"
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    set_lsp_folding(args)
  end
})
