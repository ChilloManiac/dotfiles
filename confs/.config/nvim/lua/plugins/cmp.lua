vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-nvim-lua",
  "https://github.com/onsails/lspkind.nvim",
  "https://github.com/L3MON4D3/LuaSnip"
})

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  sources = {
    { name = "luasnip",              max_item_count = 5 },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer",               keyword_length = 4 },
    { name = "vim-dadbod-completion" },
    { name = "neorg" },
    { name = "lazydev",              group_index = 0 }
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    format = lspkind.cmp_format(),
  },
})
