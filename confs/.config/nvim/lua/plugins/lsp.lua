local M = {
  "neovim/nvim-lspconfig",
  events = { "VeryLazy" },
  dependencies = {
    -- LSP Support
    { "williamboman/mason-lspconfig.nvim" },
    { "williamboman/mason.nvim" },

    -- Neodev
    { "folke/neodev.nvim" },

    -- Dap
    { "jay-babu/mason-nvim-dap.nvim" },

    -- Lint
    { "mfussenegger/nvim-lint" },

    -- Format
    { "stevearc/conform.nvim" },
  },
}

local ensure_installed = {
  "biome",
  "cssls",
  "dockerls",
  "elixirls",
  -- 'eslint',
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  -- 'pbls', Not in mason-lspconfig??
  "powershell_es",
  "pyright",
  "spectral",
  "sqlls",
  "tailwindcss",
  "terraformls",
  "tflint",
  "vtsls",
  "yamlls",
  "vimls",
}

local border = {
  { "┌", "FloatBorder" },
  { "─", "FloatBorder" },
  { "┐", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┘", "FloatBorder" },
  { "─", "FloatBorder" },
  { "└", "FloatBorder" },
  { "│", "FloatBorder" },
}

M.config = function()
  require("neodev").setup()
  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities =
      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

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
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  }

  -- Add border to the diagnostic popup window
  vim.diagnostic.config({
    virtual_text = {
      prefix = "■ ",
    },
    float = { border = border },
  })

  local default_setup = function(server)
    lspconfig[server].setup({
      on_attach = on_attach,
      handlers = handlers,
    })
  end

  local spectral_setup = function()
    lspconfig.spectral.setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = {
        enable = true,
        run = "onType",
        rulesetFile = "./.spectral.yaml",
        validateFiles = "**/*-api.yaml"
      }
    })
  end

  local lua_setup = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "awesome" },
          },
          hint = { enable = true },
        },
      },
    })
  end


  local elixirls_setup = function()
    lspconfig.elixirls.setup({
      on_attach = on_attach,
      handlers = handlers,
    })
  end

  local tsserver_setup = function()
    lspconfig.tsserver.setup({
      root_dir = lspconfig.util.root_pattern("package.json", "yarn.lock", ".git"),
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
          importModuleSpecifierPreference = "non-relative",
        },
      },
    })
  end

  local tailwindcss_setup = function()
    lspconfig.tailwindcss.setup({
      init_options = {
        userLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          heex = "html-eex",
        },
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              'class[:]\\s*"([^"]*)"',
            },
          },
        },
      },
    })
  end

  local eslint_setup = function()
    lspconfig.eslint.setup({
      root_dir = lspconfig.util.root_pattern("package.json", "yarn.lock", ".git"),
      handlers = handlers,
      flags = {
        debounce_text_changes = 500,
      },
      on_attach = function(client, bufnr)
        local au_eslint_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
          group = au_eslint_lsp,
        })
      end,
    })
  end

  require("mason").setup({})
  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    handlers = {
      default_setup,
      ["pbls"] = default_setup, -- Not setup otherwise it seems
      ["lua_ls"] = lua_setup,
      ["eslint"] = eslint_setup,
      ["tsserver"] = tsserver_setup,
      ["elixirls"] = elixirls_setup,
      ["tailwindcss"] = tailwindcss_setup,
      ["spectral"] = spectral_setup,
    },
  })

  require("mason-nvim-dap").setup({
    ensure_installed = {
      "js",
      "python",
    },
    automatic_installation = false,
  })

  -- Lint
  require("lint").linters_by_ft = {
    markdown = { "markdownlint" },
    python = { "flake8" },
    -- yaml = { "prettier " },
    typescript = nil,
    javascript = nil,
    go = { "revive" }
  }

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })

  -- Format
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      terraform = { "terraform_fmt" },
      typescript = { "biome", },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      sql = { "sqlfluff" },
      markdown = { "prettier" },
      go = { "gofmt" },
      -- yaml = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  })
end

return M
