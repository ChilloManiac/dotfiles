-- # https://manytools.org/hacker-tools/ascii-banner/
-- Header

local function file_to_table(file_path)
  local lines = {}
  local file = io.open(file_path, "r")
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
  else
    print("Could not open file: " .. file_path)
  end
  return lines
end

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

  -- local banner_3 = file_to_table(vim.fn.stdpath("config") .. "/images/me")

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
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = header()
    dashboard.section.footer.val = footer()

    -- Menu
    -- TODO: Add projects and Frecency?
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("LDR p l", "  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("LDR q", "  Quit", "<cmd>qa<CR>"),
    }

    alpha.setup(dashboard.config)
  end,
}
