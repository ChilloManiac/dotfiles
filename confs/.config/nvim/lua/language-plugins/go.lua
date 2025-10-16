vim.pack.add({
  "https://github.com/ray-x/go.nvim",
  "https://github.com/ray-x/guihua.lua",
})

require("go").setup({
  luasnip = true,
  dap_debug_gui = false,
  dap_debug_keymap = false
})



local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})
