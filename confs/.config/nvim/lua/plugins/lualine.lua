vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

local lualine = require('lualine')
lualine.setup({
  sections = {
    lualine_a = { "mode", "filename" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "diagnostics", "searchcount" },
    lualine_x = { "overseer" },
    lualine_y = { "location", },
    lualine_z = { "encoding", "filetype" },
  },
})
