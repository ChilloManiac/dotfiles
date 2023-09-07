local M = {
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6',
    opts={
        --Config goes here
    },
}

M.config = function()
  local ua = require('ultimate-autopair')

  ua.setup({
      {'<', '>', surround=true}
  })
end

return M
