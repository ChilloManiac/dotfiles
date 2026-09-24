-- This file is just for writing and executing random vim commands through lua
-- Using <leader>sl

-- Wrap in acwrite buffers (Claude Code diff splits)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "acwrite" and vim.bo.filetype == "markdown" then
      vim.wo.wrap = true
      vim.wo.linebreak = true
    end
  end,
})
