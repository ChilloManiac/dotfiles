vim.pack.add({
  "https://github.com/stevearc/overseer.nvim",
})

local overseer = require('overseer')
vim.keymap.set('n', '<leader>ot', ':OverseerToggle<CR>', { desc = "Overseer Toggle" })
vim.keymap.set('n', '<leader>orr', ':OverseerRun<CR>', { desc = "Overseer Run" })
vim.keymap.set('n', '<leader>orc', ':OverseerRunCmd<CR>', { desc = "Overseer Run CMD" })

overseer.setup({
  task_list = {
    direction = 'left'
  }
})
