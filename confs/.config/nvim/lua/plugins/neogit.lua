local M = {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
  },
  keys = {
    { "<leader>gs", ":Neogit<CR>", "Neogit" },
  },
  config = function()
    require("neogit").setup({
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      disable_builtin_notifications = false,
      commit_popup = {
        kind = "split",
      },
      integrations = {
        diffview = true,
      },
    })
  end
}


return M
