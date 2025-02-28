local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
  },
  keys = {
    { "<F5>",        function() require("dap").continue() end,                                                    desc = "Continue" },
    { "<F10>",       function() require("dap").step_over() end,                                                   desc = "Step Over" },
    { "<F11>",       function() require("dap").step_into() end,                                                   desc = "Step Into" },
    { "<F12>",       function() require("dap").step_out() end,                                                    desc = "Step Out" },
    { "<leader>b",   function() require("dap").toggle_breakpoint() end,                                           desc = "Toggle Breakpoint" },
    { "<leader>dbc", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,        desc = "Set Breakpoint with Condition" },
    { "<leader>dbl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Set Log Point Message" },
    { "<leader>dui", function() require("dapui").toggle() end,                                                    desc = "Toggle Dap UI" },
    { "<leader>dbh", function() require("dap").run_to_cursor() end,                                               desc = "Run to Cursor" },
    { "<leader>dbe", function() require("dapui").eval(nil, { enter = true }) end,                                 desc = "Evaluate under cursor" }
  }
}

M.config = function()
  local dap = require('dap')
  require('dapui').setup()

  require("nvim-dap-virtual-text").setup({
    display_callback = function(variable, buf, stackframe, node, options)
      if #variable.value > 25 then
        return " " .. string.sub(variable.value, 1, 25) .. "... "
      end

      return " " .. variable.value
    end,
  })

  vim.fn.sign_define('DapBreakpoint', { text = '👉', texthl = '', linehl = '', numhl = '' })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    callback = function()
      require('dap.ext.autocompl').attach()
    end,
  })

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
