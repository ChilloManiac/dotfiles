local M = {
  'stevearc/overseer.nvim',
  opts = {},
  keys = {
    { '<leader>ot', ':OverseerToggle<CR>', desc = "Overseer Toggle" },
    { '<leader>or', ':OverseerRun<CR>', desc = "Overseer Run" },
    { '<leader>oc', ':OverseerRunCmd', desc = "Overseer Run CMD" },
  },
}

M.config = function()
  require('overseer').setup()
end

return M
