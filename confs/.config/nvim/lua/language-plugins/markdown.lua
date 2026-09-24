vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim"
})

local rm = require("render-markdown")
rm.setup({
  enabled = false,
  completions = { lsp = { enabled = true } },
  code = { conceal_delimiters = false, border = 'thick' },
  anti_conceal = { enabled = true }
})


vim.keymap.set("n", "<leader>mm", ":RenderMarkdown toggle<CR>", { desc = "Toggle Render Markdown" })
