return {
  -- nvim-colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = { "VeryLazy" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = true,        -- "Name" codes like Blue or blue
        RRGGBBAA = false,    -- #RRGGBBAA hex codes
        AARRGGBB = false,    -- 0xAARRGGBB hex codes
        rgb_fn = false,      -- CSS rgb() and rgba() functions
        hsl_fn = false,      -- CSS hsl() and hsla() functions
        css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,                                -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false,
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
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
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    events = { "VimEnter" },
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
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
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
  { "numToStr/Comment.nvim",                event = { "VeryLazy" },      opts = {} },
  { "davidgranstrom/nvim-markdown-preview", cmd = { "MarkdownPreview" }, opts = {} },
  { "windwp/nvim-autopairs",                event = { "InsertEnter" },   opts = {} },
  { "kylechui/nvim-surround",               event = { "VeryLazy" },      opts = {} },
  { "tummetott/unimpaired.nvim",            event = { "VeryLazy" },      opts = {} },
}
