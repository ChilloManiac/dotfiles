vim.pack.add({
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  -- Adapters
  "https://github.com/nvim-neotest/neotest-jest",
})

local neotest = require("neotest")
require("neotest-jest")

vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end,
  { desc = "Test Nearest", noremap = true })
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run({ vim.fn.expand("%") }) end,
  { desc = "Test File", noremap = true })
vim.keymap.set("n", "<leader>ta", function() require("neotest").run.run({ suite = true }) end,
  { desc = "Test Suite", noremap = true })
vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end,
  { desc = "Test Last", noremap = true })
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,
  { desc = "Test File with Debug", noremap = true })
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end,
  { desc = "Test Summary", noremap = true })

neotest.setup({
  status = {
    virtual_text = true,
    signs = true,
  },
  icons = {
    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  },
  quickfix = {
    enabled = false,
  },
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
  discovery = {
    enabled = false, -- disabled for jest
  },
  adapters = {
    -- require("neotest-jest")({
    --   jestCommand = "npm test --ignore-scripts --",
    --   -- jest_test_discovery = false,
    --   cwd = function()
    --     return vim.fn.getcwd()
    --   end,
    -- }),
  },
})
