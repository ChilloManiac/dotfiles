local colorizer = {
  'NvChad/nvim-colorizer.lua',
  event = { "BufReadPre" },
  opts =
  {
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
      tailwind = true,                                 -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
      virtualtext = "■",
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = false
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
  },
}

local gx = {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  cmd = { "Browse" },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true, -- default settings
}

local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  events = { 'VimEnter' },
  opts = {}
}

local ntree = {
  "kyazdani42/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
  },
  opts = {
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
    },
    renderer = {
      group_empty = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
  }
}

local swagger_preview = {
  'vinnymeller/swagger-preview.nvim',
  cmd = {
    "SwaggerPreview",
    "SwaggerPreviewStop",
    "SwaggerPreviewToggle"
  },
  config = function()
    require("swagger-preview").setup({
      -- The port to run the preview server on
      port = 8000,
      -- The host to run the preview server on
      host = "localhost",
    })
  end
}

local whichkey = {
  "folke/which-key.nvim",
  event = 'BufReadPre',
  cmd = 'WhichKey',
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
  end
}


return {
  colorizer,
  gx,
  lualine,
  ntree,
  swagger_preview,
  whichkey,
  { 'numToStr/Comment.nvim',                event = { "BufReadPre" } },
  { 'davidgranstrom/nvim-markdown-preview', cmd = { 'MarkdownPreview' } },
  { 'windwp/nvim-autopairs',                event = { "InsertEnter" } },
  { 'smoka7/hop.nvim',                      keys = { { 'mm', '<cmd>HopWord<CR>', "Hop Word" } } },
  { "kylechui/nvim-surround",               event = { "BufReadPre" },                           opts = {} },
  { 'tummetott/unimpaired.nvim',            event = { "BufReadPre" },                           opts = {} }
}
