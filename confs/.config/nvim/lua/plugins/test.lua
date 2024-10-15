local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",

    -- Adapters
    "nvim-neotest/neotest-jest",
  },
  keys = {
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Test Nearest",
      { noremap = true },
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run({ vim.fn.expand("%") })
      end,
      desc = "Test File",
      { noremap = true },
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run({ suite = true })
      end,
      desc = "Test Suite",
      { noremap = true },
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Test Last",
      { noremap = true },
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Test File with Debug",
      { noremap = true },
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Test Summary",
      { noremap = true },
    },
  },
}

M.config = function()
  local neotest = require("neotest")

  require("neotest-jest")

  neotest.setup({
    status = {
      virtual_text = true,
      signs = true,
    },
    icons = {
      running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    },
    consumers = {
      overseer = require("neotest.consumers.overseer"),
    },
    adapters = {
      require("neotest-jest")({
        jestCommand = "npm test --",
        jestConfigFile = 'jest.integration.config.js',
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      }),
    },
  })
end

return M
