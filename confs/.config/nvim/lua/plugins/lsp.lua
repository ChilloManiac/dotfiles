return {
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy", },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    keys = {
      "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info",
    },
    dependencies = {
      { "williamboman/mason.nvim",           opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
      { "folke/lazydev.nvim",                ft = "lua", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")
      require("mason").setup({})
      -- local lsp_configs = require("lspconfig.configs")
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities =
          vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "<leader>fb", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
        vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
      end

      -- if not lsp_configs.typescript_go then
      --   lsp_configs.typescript_go = {
      --     default_config = {
      --       cmd = { "/Users/dkchrnor/cnor/typescript-go/built/local/tsgo", "lsp", "--stdio" },
      --       filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      --       root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
      --       settings = {},
      --     },
      --   }
      -- end

      local default_setup_lsps = {
        "biome",
        "bashls",
        "cssls",
        "dockerls",
        "elixirls",
        "gopls",
        "html",
        "jsonls",
        "marksman",
        "powershell_es",
        "pyright",
        "sqlls",
        "terraformls",
        "tflint",
        "vtsls",
        "yamlls",
        "vimls",
      }

      for _, server in ipairs(default_setup_lsps) do
        lspconfig[server].setup({
          on_attach = on_attach,
        })
      end


      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "awesome" },
            },
            hint = { enable = true }
          },
        },
      })
      lspconfig.spectral.setup({
        on_attach = on_attach,
        settings = {
          enable = true,
          run = "onType",
          rulesetFile = "./.spectral.yaml",
          validateFiles = "**/*-api.yaml"
        }
      })
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePre" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        python = { "flake8" },
        lua = { "luacheck" },
        typescript = {},
        javascript = {},
        go = { "revive" }
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>fdb",
        function()
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          if vim.b.disable_autoformat then return vim.notify("Disabled autoformat for buffer") end
          vim.notify("Enabled autoformat for buffer")
        end,
        desc = "Toggle disable autoformat for buffer"
      },
      {
        "<leader>fdd",
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          if vim.g.disable_autoformat then return vim.notify("Disabled autoformat for all buffers") end
          vim.notify("Enabled autoformat for all buffers")
        end,
        desc = "Toggle disable autoformat for all buffers"
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          terraform = { "terraform_fmt" },
          typescript = { "biome", "biome-check", },
          javascript = { "biome", "biome-check" },
          javascriptreact = { "biome", "biome-check" },
          typescriptreact = { "biome", "biome-check" },
          sql = { "sqlfluff" },
          markdown = { "prettier" },
          go = { "gofmt" },
          yaml = { "prettier" },
          bash = { "shfmt" },
          shell = { "shfmt" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
          return { timeout_ms = 1000, lsp_fallback = true }
        end,
      })
    end
  },
}
