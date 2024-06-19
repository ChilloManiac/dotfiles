local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "nvim-neotest/nvim-nio" },
    { "rcarriga/nvim-dap-ui" },
  },
  keys = {
    {
      "<F5>",
      function() require("dap").continue() end,
      desc =
      "Continue"
    },
    {
      "<F10>",
      function() require("dap").step_over() end,
      desc =
      "Step Over"
    },
    {
      "<F11>",
      function() require("dap").step_into() end,
      desc =
      "Step Into"
    },
    {
      "<F12>",
      function() require("dap").step_out() end,
      desc =
      "Step Out"
    },
    {
      "<leader>b",
      function() require("dap").toggle_breakpoint() end,
      desc =
      "Toggle Breakpoint"
    },
    {
      "<leader>dsc",
      function() require("dap.ui.variables").scopes() end,
      desc =
      "Scopes"
    },
    {
      "<leader>dhh",
      function() require("dap.ui.variables").hover() end,
      desc =
      "Hover Variables"
    },
    {
      "<leader>dhv",
      function() require("dap.ui.variables").visual_hover() end,
      desc =
      "Visual Hover Variables"
    },
    {
      "<leader>duh",
      function() require("dap.ui.widgets").hover() end,
      desc =
      "Hover"
    },
    {
      "<leader>duf",
      function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end,
      desc =
      "Float Scopes"
    },
    {
      "<leader>dsbr",
      function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      desc =
      "Set Breakpoint with Condition"
    },
    {
      "<leader>dsbm",
      function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
      desc =
      "Set Log Point Message"
    },
    {
      "<leader>dro",
      function() require("dap").repl.open() end,
      desc =
      "Open REPL"
    },
    {
      "<leader>drl",
      function() require("dap").repl.run_last() end,
      desc =
      "Run Last"
    },
    {
      "<leader>dui",
      function() require("dapui").toggle() end,
      desc = "Toggle Dap UI"
    }
  }
}

M.config = function()
  local dap = require('dap')
  require('dapui').setup()
  vim.fn.sign_define('DapBreakpoint', { text = '👉', texthl = '', linehl = '', numhl = '' })

  -- Adapters
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "js-debug-adapter",
      args = { "${port}" },
    }
  }

  -- js/ts config
  for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Test file",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
          "${file}",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
  end
end

return M
