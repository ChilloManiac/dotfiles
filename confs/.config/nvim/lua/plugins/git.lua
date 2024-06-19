return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    keys = {
      { "<leader>gs", ":Neogit<CR>",      { desc = "Neogit" } },
      { "<leader>gp", ":Neogit pull<CR>", { desc = "Git pull" } },
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
  },
  {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    "FabijanZulj/blame.nvim",
    keys = {
      { "<leader>gl", "<cmd>BlameToggle window<CR>", { desc = "Blame" } },
    },
    cmd = { "BlameToggle" },
    opts = {},
    config = true
  }
}
