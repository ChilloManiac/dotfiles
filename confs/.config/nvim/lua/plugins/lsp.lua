local M = {
  "neovim/nvim-lspconfig",
  events = { "InsertEnter" },
  dependencies = {
    -- LSP Support
    { "williamboman/mason-lspconfig.nvim" },
    { "williamboman/mason.nvim" },

    -- Neodev
    { "folke/neodev.nvim" },

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
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
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

    vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "<leader>fb", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
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
    ---@diagnostic disable-next-line: assign-type-mismatch
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
  require("mason").setup({})
  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    handlers = {
      default_setup,
      ["lua_ls"] = lua_setup,
      ["spectral"] = spectral_setup,
    },
  })

  -- Lint
  require("lint").linters_by_ft = {
    markdown = { "markdownlint" },
    python = { "flake8" },
    typescript = {},
    javascript = {},
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
      yaml = { "prettier" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { timeout_ms = 1000, lsp_fallback = true }
    end,
  })

  vim.keymap.set('n', '<leader>fdb', function()
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    if vim.b.disable_autoformat then return vim.notify("Disabled automatic formatting for buffer") end
    vim.notify("Enabled automatic formatting enabled for buffer")
  end)

  vim.keymap.set('n', '<leader>fdd', function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    if vim.g.disable_autoformat then return vim.notify("Disabled automatic formatting for all buffers") end
    vim.notify("Enabled automatic formatting for all buffers")
  end)
end

return M
