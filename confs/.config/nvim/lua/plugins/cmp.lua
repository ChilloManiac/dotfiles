local M = {
  "hrsh7th/nvim-cmp",
  event = { 'BufReadPre' },
  dependencies = {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },

    -- Snippet engine
    { "L3MON4D3/LuaSnip" },
  },
}

M.config = function()
  require("luasnip").setup({})

  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  cmp.setup({
    sources = {
      { name = 'path' },
      { name = 'vim-dadbod-completion' },
      { name = 'neorg' },
      { name = 'nvim_lsp',             keyword_length = 1 },
      { name = 'buffer',               keyword_length = 4 },
      { name = 'luasnip',              keyword_length = 2 },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = nil,
      ["<S-Tab>"] = nil,
      ["<C-Space>"] = cmp.mapping({
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
end

return M
