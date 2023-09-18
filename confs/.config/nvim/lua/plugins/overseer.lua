local M = {
  'stevearc/overseer.nvim',
  opts = {},
  keys = {
    { '<leader>ot', ':OverseerToggle<CR>', desc = "Overseer Toggle" },
    { '<leader>orr', ':OverseerRun<CR>', desc = "Overseer Run" },
    { '<leader>orc', ':OverseerRunCmd', desc = "Overseer Run CMD" },
  },
}

M.config = function()
  require('overseer').setup({
    task_list = {
      direction = 'right'
    }
  })
end

return M
