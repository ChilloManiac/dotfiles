---@diagnostic disable: missing-fields
local M = {
  "neovim/nvim-lspconfig",
  event = { 'BufReadPre' },
  dependencies = {
    -- LSP Support
    { "williamboman/mason-lspconfig.nvim" },
    { "williamboman/mason.nvim" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp", },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },

    -- Neodev
    { "folke/neodev.nvim" },

    -- Snippet engine
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },

    -- Dap
    { "jay-babu/mason-nvim-dap.nvim" },

    -- Lint
    { "mfussenegger/nvim-lint" },
  },
}

local ensure_installed = {
  'cssls',
  'dockerls',
  'elixirls',
  'eslint',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'powershell_es',
  'pyright',
  'spectral',
  'sqlls',
  'tailwindcss',
  'terraformls',
  'tflint',
  'tsserver',
  'vimls',
}

local border = {
  { '┌', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '┐', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '┘', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '└', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

M.config = function()
  require("neodev").setup()
  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend("force",
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "<leader>fb", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint(bufnr, true)
    -- end
  end

  local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  }

  -- Add border to the diagnostic popup window
  vim.diagnostic.config({
    virtual_text = {
      prefix = '■ ',
    },
    float = { border = border },
  })

  local default_setup = function(server)
    lspconfig[server].setup({
      on_attach = on_attach,
      handlers = handlers,
    })
  end

  local lua_setup = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          hint = { enable = true }
        },
      },
    })
  end

  local tsserver_setup = function()
    lspconfig.tsserver.setup({
      root_dir = lspconfig.util.root_pattern(
        "package.json",
        "yarn.lock",
        ".git"
      ),
      handlers = handlers,
      on_attach = on_attach,
      init_options = {
        preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          importModuleSpecifierPreference = 'non-relative'
        },
      },
    })
  end

  local eslint_setup = function()
    lspconfig.eslint.setup({
      root_dir = lspconfig.util.root_pattern(
        "package.json",
        "yarn.lock",
        ".git"
      ),
      handlers = handlers,
      flags = {
        debounce_text_changes = 500,
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        if client.server_capabilities.documentFormattingProvider then
          local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
            group = au_lsp,
          })
        end
      end
    })
  end

  require("mason").setup({})
  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    handlers = {
      default_setup,
      ["lua_ls"] = lua_setup,
      ["eslint"] = eslint_setup,
      ["tsserver"] = tsserver_setup,
    },
  })

  require("mason-nvim-dap").setup({
    ensure_installed = {
      "js",
      "python",
    },
    automatic_installation = false
  })

  require("luasnip").setup({})

  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  cmp.setup({
    sources = {
      { name = 'path' },
      { name = 'vim-dadbod-completion' },
      { name = 'nvim_lsp', keyword_length = 1 },
      { name = 'buffer',   keyword_length = 3 },
      { name = 'luasnip',  keyword_length = 2 },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = nil,
      ["<S-Tab>"] = nil,
      ["<C-.>"] = cmp.mapping({
        i = function()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end,
        c = function()
          if cmp.visible() then
            cmp.close()
          else
            cmp.complete()
          end
        end,
      }),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    }
  })

  -- Lint
  require("lint").linters_by_ft = {
    markdown = { "markdownlint" },
  }

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })
end

return M
