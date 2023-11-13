-- # https://manytools.org/hacker-tools/ascii-banner/
-- Header
local function header()
  local banner_small = {
    "                                                                                 ",
    "                                                                                 ",
    "                                                                                 ",
    "                                                                                 ",
    "  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
    "  ░░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░   ░░░░░░░░░░░░░░░░░░░░░░",
    "  ▒▒▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒   ▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒",
    "  ▒▒   ▒▒▒▒▒▒▒▒   ▒   ▒▒▒▒▒▒   ▒▒▒▒▒  ▒    ▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒▒▒    ▒   ▒   ▒▒▒▒▒",
    "  ▓▓   ▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓   ▓▓   ▓▓▓   ▓▓▓▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓▓▓",
    "  ▓▓   ▓▓▓▓▓▓▓▓▓   ▓▓   ▓   ▓▓▓▓   ▓▓   ▓▓▓▓▓▓▓▓   ▓   ▓▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓▓▓",
    "  ▓▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓   ▓▓   ▓▓▓   ▓▓▓▓▓▓▓▓▓     ▓▓▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓▓▓",
    "  █████     ███    ██   ████   █████    ██████████   ███████   █    ██  ██   ████",
    "  ███████████████████████████████████████████████████████████████████████████████",
    "                                                                                 ",
    "                                                                                 ",
    "                                                                                 ",
    "                                                                                 ",
  }

  local banner_2 = {
    "",
    "",
    "",
    "   █████████                              █████   █████ ███",
    "  ███░░░░░███                            ░░███   ░░███ ░░░",
    " ███     ░░░ ████████    ██████  ████████ ░███    ░███ ████ █████████████",
    "░███        ░░███░░███  ███░░███░░███░░███░███    ░███░░███░░███░░███░░███",
    "░███         ░███ ░███ ░███ ░███ ░███ ░░░ ░░███   ███  ░███ ░███ ░███ ░███",
    "░░███     ███░███ ░███ ░███ ░███ ░███      ░░░█████░   ░███ ░███ ░███ ░███",
    " ░░█████████ ████ █████░░██████  █████       ░░███     ██████████░███ █████",
    "  ░░░░░░░░░ ░░░░ ░░░░░  ░░░░░░  ░░░░░         ░░░     ░░░░░░░░░░ ░░░ ░░░░░",
    "",
    "",
    "",
  }

  return banner_2
end
-- Footer
local function footer()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local datetime = os.date("%Y/%m/%d %H:%M:%S")

  return {
    " ",
    print_version .. " - " .. datetime,
  }
end

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = header()
    dashboard.section.footer.val = footer()

    -- Menu
    -- TODO: Add projects and Frecency?
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("LDR f f", "  Find files", "<cmd>Telescope find_files<CR>"),
      dashboard.button("LDR f r", "󰔠  Recent files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("LDR f p", "󱠏  Projects", "<cmd>Telescope projects<CR>"),
      dashboard.button("LDR v e", "  Config", "<cmd>:edit ~/.config/nvim/init.lua<CR>"),
      dashboard.button("LDR p l", "  Plugins", "<cmd>Lazy<CR>"),
      dashboard.button("LDR q", "  Quit", "<cmd>qa<CR>"),
    }

    alpha.setup(dashboard.config)
  end,
}
