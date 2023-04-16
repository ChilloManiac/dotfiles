vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy_packages")

-- Set up the Floaterm plugin
vim.g.floaterm_shell = "fish"
vim.g.floaterm_keymap_new = "<F7>"
vim.g.floaterm_keymap_prev = "<F8>"
vim.g.floaterm_keymap_next = "<F9>"
vim.g.floaterm_keymap_toggle = "<F12>"

-- disable netrw at the very start of your init.lua (strongly advised)

require("globals")
require("keybinds")

