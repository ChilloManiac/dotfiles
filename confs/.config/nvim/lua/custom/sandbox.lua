local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local a = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Get capabilities of the current LSP server
local current_servers = vim.lsp.get_clients()
for _, server in ipairs(current_servers) do
  vim.print("Current LSP server: " .. server.name)
end
