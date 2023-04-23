local M = {
  "github/copilot.vim",
  config = function()
    -- disallow github copilot on telescope prompt
    vim.g.copilot_filetypes = {
      TelescopePrompt = false,
      ["dap-repl"] = false,
    }
  end,
}

return M
