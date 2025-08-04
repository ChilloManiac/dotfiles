local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local a = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.print(vim.inspect(a))
