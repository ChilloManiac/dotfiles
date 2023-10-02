local M = {
  'nvim-neotest/neotest',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",

    -- Adapters
    'nvim-neotest/neotest-jest',
  },
  keys = {
    {
      '<leader>tn',
      '<cmd>lua require("neotest").run.run()<CR>',
      desc = 'Test Nearest',
      { noremap = true }
    },
    { '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Test File', { noremap = true } },
    {
      '<leader>ta',
      '<cmd>lua require("neotest").run.run({ suite = true})<CR>',
      desc = 'Test Suite',
      { noremap = true }
    },
    { '<leader>tl', '<cmd>lua require("neotest").run.run_last()<CR>',              desc = 'Test Last', { noremap = true } },
    {
      '<leader>td',
      '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
      desc = 'Test File with Debug',
      { noremap = true }
    },
    {
      '<leader>ts',
      '<cmd>lua require("neotest").summary.toggle()<CR>',
      desc = 'Test Summary',
      { noremap = true }
    },
  }
}

M.config = function()
  local neotest = require('neotest')

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
      require('neotest-jest')({
        jestCommand = 'yarn test',
        --jestConfigFile = 'jest.integration.config.js',
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      })
    }
  })
end

return M
