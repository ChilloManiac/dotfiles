local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "onsails/lspkind.nvim" },
    {
      "petertriho/cmp-git",
      config = function()
        if (vim.g.is_github_cli) then
          require("cmp_git").setup({
            filetypes = { "markdown", "gitcommit" }
          })
        else
          require("cmp_git").setup({
            filetypes = { "gitcommit" }
          })
        end
      end
    },

    -- Snippet engine
    { "L3MON4D3/LuaSnip" },
  },
}

M.config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.setup({
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer",               keyword_length = 4 },
      { name = "vim-dadbod-completion" },
      { name = "neorg" },
      { name = "git",                  keyword_length = 3 }
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
end


return M
