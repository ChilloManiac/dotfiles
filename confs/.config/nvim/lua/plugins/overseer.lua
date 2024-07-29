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
      direction = 'left'
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

  -- Setup custom exercism tasks
  local exercism_dir = vim.fn.expand('$HOME/exercism')

  overseer.register_template({
    name = "Exercism Submit",
    builder = function()
      return {
        cmd = "exercism",
        args = { "submit" },
        name = "Exercism Submit",
      }
    end,
    condition = {
      dir = exercism_dir
    }
  })

  overseer.register_template({
    name = "Exercism Test",
    builder = function()
      return {
        cmd = "exercism",
        args = { "test" },
        name = "Exercism Test",
      }
    end,
    condition = {
      dir = exercism_dir
    }
  })
end

return M
