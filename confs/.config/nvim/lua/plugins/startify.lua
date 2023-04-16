local M = {
  "goolord/alpha-nvim",
  opts = {},
}

M.config = function(_, opts)
  local alpha = require("alpha")
  local cfg_r = require("alpha.themes.startify")


  cfg_r.mru_opts.autocd = true
  cfg_r.section.header.val = {
[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢻⣿⡟⢻⣿]],
[[⣿⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣄⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⡇⢸⣿]],
[[⣿⠛⠛⠛⠛⠛⠛⠛⠛⠻⣿⣿⣿⣷⡄⠉⠉⠻⣿⣿⣿⣿⣿⣿⡇⢸⣿⡇⢸⣿]],
[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡈⠻⣿⣿⣇⠀⠀⢀⣿⣿⣿⣿⣿⡿⠃⣸⣿⡇⢸⣿]],
[[⣿⣉⣉⣉⣉⣉⠙⢿⣿⣿⣿⡆⠀⠀⢹⣿⣿⡿⠋⣀⠙⠿⠋⣠⣾⣿⠟⢁⣼⣿]],
[[⣿⣿⣿⣿⣿⣿⣷⣄⠙⠿⠿⣧⣤⣤⣼⡿⠋⣠⡾⠛⣷⣄⡘⠿⠟⢁⣴⣿⣿⣿  Simons legendary]],
[[⣿⠉⠻⣿⣿⣿⣿⣿⡀⠀⠀⣿⣿⡿⠋⣠⡾⠋⣠⣾⣟⠙⢿⣦⡀⢿⣿⣿⣿⣿  omega awesome ]],
[[⣿⣄⠀⠘⢿⣿⣿⣿⣿⣶⣶⡿⠋⣠⡾⠋⣠⣾⠟⠉⠙⢷⣄⠙⢿⣦⠙⢿⣿⣿  NeoVIM config]],
[[⣿⢿⣷⣄⠀⠙⢿⣿⣿⣿⣿⣦⡘⢿⣄⠈⠻⣿⡀⠀⠀⣸⡿⠃⣠⠟⢁⣴⣿⣿]],
[[⣿⠀⠙⢿⣷⣄⠀⠙⠻⣿⣿⣿⣿⣦⡉⠳⣦⡈⠻⣷⣿⢋⣴⠞⢁⣴⣿⣿⣿⣿]],
[[⣿⣧⡀⠀⠙⢿⣷⣄⠀⠈⠻⣿⣿⣿⣿⣦⡈⠻⣦⢈⣿⠟⢁⣴⣿⡿⠿⣿⣿⣿]],
[[⣿⠙⢿⣦⡀⠀⠙⢿⣷⣄⠀⢹⣿⣿⣿⣿⣿⠆⠈⠟⢁⣴⣿⣿⡏⠀⠀⠘⣿⣿]],
[[⣿⠀⠀⠙⣿⣦⡀⠀⣿⣿⡇⢸⣿⣿⣿⠟⣡⣾⣿⣶⣿⡿⠛⠛⢿⣤⣤⡈⠻⣿]],
[[⣿⣷⣄⠀⣿⣿⡇⠀⣿⣿⡇⢸⣿⣿⡇⢸⣿⣿⣿⣿⣿⡄⠀⠀⢨⣿⣿⣿⣦⣿]],
[[⣿⣿⣿⣤⣿⣿⣧⣤⣿⣿⣧⣼⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣷⣤⣽⣿⣿⣿⣿]],
  }

  -- set the buttons to use for projects
  cfg_r.section.bottom_buttons.val = {
    cfg_r.file_button("~/.config/nvim/init.lua", "c", nil, { autocd = true }),
    cfg_r.file_button("~/.config/fish/config.fish", "f", nil, { autocd = true }),
  }

  alpha.setup(cfg_r.config)

  -- Set a normal mode key mapping for <leader>x
  vim.keymap.set("n", "<leader>x", function()
    vim.cmd("bufdo bd")
    vim.cmd("Alpha")
  end, { noremap = true })
end

return M
