local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "mxsdev/nvim-dap-vscode-js" },
    {
      "microsoft/vscode-js-debug",
      tag = "v1.74.1",
      build =
      "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
  },
  keys = {
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc =
      "Continue"
    },
    {
      "<leader>dvo",
      function() require("dap").step_over() end,
      desc =
      "Step Over"
    },
    {
      "<leader>di",
      function() require("dap").step_into() end,
      desc =
      "Step Into"
    },
    {
      "<leader>do",
      function() require("dap").step_out() end,
      desc =
      "Step Out"
    },
    {
      "<leader>db",
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
  }
}

M.config = function()
  require('dap-vscode-js').setup({
    debugger_path = vim.fn.stdpath('data') .. '/lazy/packages/vscode-js-debug',
    debugger_cmd = { 'js-debug-adapter' },
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  })

  local dap = require('dap')

  -- language config
  for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
      {
        name = 'Launch',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '<node_internals>/**' },
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        name = 'Attach to node process',
        type = 'pwa-node',
        request = 'attach',
        rootPath = '${workspaceFolder}',
        processId = require('dap.utils').pick_process,
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        port = 8123,
      }
    }
  end
end

return M