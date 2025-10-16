vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/nvim-neotest/nvim-nio",
})

local dap = require('dap')
require('dapui').setup()

require("nvim-dap-virtual-text").setup({
  display_callback = function(variable)
    if #variable.value > 25 then
      return " " .. string.sub(variable.value, 1, 25) .. "... "
    end

    return " " .. variable.value
  end,
})

vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dbc", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "DAP Set Breakpoint with Condition" })
vim.keymap.set("n", "<leader>dbl", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
  { desc = "DAP Set Log Point Message" })
vim.keymap.set("n", "<leader>dui", function() require("dapui").toggle() end, { desc = "DAP Toggle Dap UI" })
vim.keymap.set("n", "<leader>dbh", function() dap.run_to_cursor() end, { desc = "DAP Run to Cursor" })
vim.keymap.set("n", "<leader>dbe", function() require("dapui").eval(nil, { enter = true }) end,
  { desc = "DAP Evaluate under cursor" })

vim.fn.sign_define('DapBreakpoint', { text = '👉', texthl = '', linehl = '', numhl = '' })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-repl",
  callback = function()
    require('dap.ext.autocompl').attach()
  end,
})

dap.defaults.fallback.switchbuf = 'useopen,vsplit'

-- Adapters
-- dap.adapters["pwa-node"] = {
--   type = "server",
--   host = "localhost",
--   port = "${port}",
--   executable = {
--     command = "js-debug-adapter",
--     args = { "${port}" },
--   }
-- }

-- js/ts config
-- for _, language in ipairs({ 'typescript', 'javascript' }) do
--   dap.configurations[language] = {
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Test file",
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--         "${file}",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Tests",
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}",
--       cwd = "${workspaceFolder}",
--     },
--   }
-- end
