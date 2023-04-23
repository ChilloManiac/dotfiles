local M = {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  event =  "BufReadPre",
  lazy = true,
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason-lspconfig.nvim" },
    { "williamboman/mason.nvim" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp",                 events = { "InsertEnter" } },
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
  },
}

M.config = function()
  require("mason").setup({
    ui = {
      keymaps = {
        apply_language_filter = "<C-l>",
      },
    }
  })
  require("neodev").setup()
  require("luasnip").setup({})

  local lsp = require("lsp-zero").preset({})
  local lspconfig = require("lspconfig")

  lsp.ensure_installed({
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
  })

  require("mason-nvim-dap").setup({
    ensure_installed = {
      "js",
      "python",
    }
  })


  -- Fix Undefined global 'vim'
  lsp.configure("lua_ls", {
    settings = {
      Lua = {
        completion = {
          callSnipper = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })


  lsp.configure("graphql", {
    root_dir = lspconfig.util.root_pattern(
      "package.json",
      "yarn.lock",
      ".git"
    ),
  })

  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  })

  cmp_mappings["<Tab>"] = nil
  cmp_mappings["<S-Tab>"] = nil

  lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
  })

  lsp.set_preferences({
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
    sign_icons = {
      error = "E",
      warn = "W",
      hint = "H",
      info = "I",
    },
  })

  lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gi", function()
      vim.lsp.buf.implementation()
    end, opts)
    vim.keymap.set("n", "gr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>fb", function()
      vim.lsp.buf.format()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>e", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "]g", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "[g", function()
      vim.diagnostic.goto_prev()
    end, opts)
  end)

  lsp.configure("eslint", {
    root_dir = lspconfig.util.root_pattern(
      "package.json",
      "yarn.lock",
      ".git"
    ),
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

  -- (Optional) Configure lua language server for neovim
  require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

  lsp.setup()
end

return M
