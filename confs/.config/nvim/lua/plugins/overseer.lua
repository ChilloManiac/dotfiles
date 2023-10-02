local M = {
  'stevearc/overseer.nvim',
  keys = {
    { '<leader>ot',  ':OverseerToggle<CR>', desc = "Overseer Toggle" },
    { '<leader>orr', ':OverseerRun<CR>',    desc = "Overseer Run" },
    { '<leader>orc', ':OverseerRunCmd',     desc = "Overseer Run CMD" },
  },
}

M.config = function()
  local overseer = require('overseer')

  overseer.setup({
    task_list = {
      direction = 'right'
    }
  })

  -- If has lua line, set up the extension
  local has_lua_line, lualine = pcall(require, 'lualine')
  if has_lua_line then
    local withSections = vim.tbl_deep_extend('force', lualine.get_config(), {
      sections = {
        lualine_x = { "overseer" }
      }
    })
    lualine.setup(withSections)
  end
end

return M
