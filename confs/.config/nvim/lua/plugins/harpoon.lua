local M = {
  'thePrimeagen/harpoon',
  keys = {
    { '<leader>hh', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Harpoon Ui" },
    { '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<cr>',        desc = "Harpoon Add File" },
    { '<C-j>',      '<cmd>lua require("harpoon.ui").nav_next()<cr>',          desc = "Harpoon Next" },
    { '<C-k>',      '<cmd>lua require("harpoon.ui").nav_prev()<cr>',          desc = "Harpoon Prev" },
    { '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',         desc = "Harpoon Goto File 1" },
    { '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',         desc = "Harpoon Goto File 2" },
    { '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',         desc = "Harpoon Goto File 3" },
    { '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',         desc = "Harpoon Goto File 4" },
    { '<leader>h5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>',         desc = "Harpoon Goto File 5" },
    { '<leader>h6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>',         desc = "Harpoon Goto File 6" },
    { '<leader>h7', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>',         desc = "Harpoon Goto File 7" },
    { '<leader>h8', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>',         desc = "Harpoon Goto File 8" },
    { '<leader>h9', '<cmd>lua require("harpoon.ui").nav_file(9)<cr>',         desc = "Harpoon Goto File 9" },
  },
  config = function()
    require('harpoon').setup()
  end
}

return M
