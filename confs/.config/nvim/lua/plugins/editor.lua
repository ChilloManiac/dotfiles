return {
  -- gx
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    lazy = false,
    opts = {
      sections = {
        lualine_a = { "filename", "filesize" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "diagnostics", "searchcount" },
        lualine_x = {},
        lualine_y = { "encoding" },
        lualine_z = { "location" },
      },
      theme = "auto",
    },
  },
  -- swagger-preview
  {
    "vinnymeller/swagger-preview.nvim",
    cmd = {
      "SwaggerPreview",
      "SwaggerPreviewStop",
      "SwaggerPreviewToggle",
    },
    config = function()
      require("swagger-preview").setup({
        -- The port to run the preview server on
        port = 8000,
        -- The host to run the preview server on
        host = "localhost",
      })
    end,
  },
  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
      })
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = { "NoNeckPain" },
    keys = {
      { "<leader>nn", "<cmd>NoNeckPain<CR>", desc = "No Neck Pain" },
    },
    opts = { width = 200 }
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC", "TSCOpen" },
    opts = {}
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        auto_preview = true,
        modes = {
          diagnostics = {
            filter = {
              severity = vim.diagnostic.severity.ERROR
            },
            {
              severity = vim.diagnostic.severity.WARN
            }
          }
        }
      })
    end,
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  { "numToStr/Comment.nvim",                event = { "VeryLazy" },    opts = {} },
  { "davidgranstrom/nvim-markdown-preview", cmd = "MarkdownPreview" },
  { "windwp/nvim-autopairs",                event = { "InsertEnter" }, opts = {} },
  { "kylechui/nvim-surround",               event = { "VeryLazy" },    opts = {} },
  { "tummetott/unimpaired.nvim",            event = { "VeryLazy" },    opts = {} },
}
