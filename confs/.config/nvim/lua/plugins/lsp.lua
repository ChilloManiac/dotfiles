vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  --"https://github.com/williamboman/mason.nvim",
  "https://github.com/folke/lazydev.nvim"
})

-- require("mason").setup({
--   ui = {
--     width = 0.5
--   }
-- })
require("lazydev").setup({})

vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.lsp.inline_completion.enable()


local default_setup_lsps = {
  "bashls",
  -- "biome",
  -- "cssls",
  "dockerls",
  -- "elixirls",
  "gopls",
  -- "html",
  -- "jsonls",
  "lua_ls",
  "marksman",
  "go"
  -- "golangci_lint_ls",
  -- "powershell_es",
  -- "pyright",
  -- "sqlls",
  -- "terraformls",
  -- "tflint",
  -- "vimls",
  -- "vtsls",
  -- "yamlls",
}

for _, server in ipairs(default_setup_lsps) do
  vim.lsp.enable(server)
end

-- Copilot support

vim.lsp.config('copilot', {
  cmd = { 'copilot-language-server', '--stdio', },
  root_markers = { '.git' },
})
-- vim.lsp.enable('copilot')

vim.keymap.set('i', '<C-CR>', vim.lsp.inline_completion.get, { desc = 'Accept LSP inline suggestion' })
local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {})

local set_lsp_folding = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end
  if client:supports_method('textDocument/foldingRange') then
    vim.b[args.buf].foldexpr = "v:lua.vim.lsp.foldexpr()"
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    set_lsp_folding(args)
    vim.b[args.buf].tagfunc = "v:lus.vim.lsp.tagfunc()"

    -- Auto-show signature help on trigger characters (, and ()
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/signatureHelp') then
      local provider = client.server_capabilities.signatureHelpProvider or {}
      local chars = vim.list_extend(
        vim.list_extend({}, provider.triggerCharacters or {}),
        provider.retriggerCharacters or {}
      )
      if #chars > 0 then
        local lookup = {}
        for _, c in ipairs(chars) do lookup[c] = true end
        vim.api.nvim_create_autocmd("TextChangedI", {
          buffer = args.buf,
          callback = function()
            local col = vim.fn.col('.') - 1
            if col < 1 then return end
            local char = vim.fn.getline('.'):sub(col, col)
            if lookup[char] then
              vim.lsp.buf.signature_help()
            end
          end,
        })
      end
    end
  end
})
