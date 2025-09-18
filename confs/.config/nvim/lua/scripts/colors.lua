local builtins = { "blue", "darkblue", "default", "delek", "desert", "elflord", "evening", "habamax", "industry",
  "koehler", "lunaperche", "morning", "murphy", "pablo", "peachpuff", "quiet", "retrobox", "ron", "shine", "slate"
, "sorbet", "torte", "unokai", "vim", "wildcharm", "zaibatsu", "zellner" }


local function cycle_color(dir)
  local direction = dir or 1
  if not vim.g.color_cycle.enabled then
    return
  end

  local next_index = vim.g.color_cycle.index + direction
  if next_index > #vim.g.color_cycle.colors then
    next_index = 1
  elseif next_index < 1 then
    next_index = #vim.g.color_cycle.colors
  end

  local next_color = vim.g.color_cycle.colors[next_index]
  local success, err = pcall(vim.cmd.colorscheme, next_color)
  if success then
    vim.g.color_cycle = {
      enabled = true,
      colors = vim.g.color_cycle.colors,
      index = next_index,
    }
    vim.notify("Color scheme changed to: [" .. next_index .. "/" .. #vim.g.color_cycle.colors .. "] " .. next_color,
      vim.log.levels.INFO, { title = "Color Cycle" })
  else
    vim.notify("Failed to change color scheme to: " .. next_color .. "\nError: " .. err, vim.log.levels.ERROR,
      { title = "Color Cycle" })
  end
end

local function stop_color_cycle()
  vim.g.color_cycle.enabled = false

  vim.keymap.del("n", "n", { buffer = true })
  vim.keymap.del("n", "p", { buffer = true })
end

local function start_color_cycle()
  local current_color = vim.g.colors_name
  local all_colors = vim.fn.getcompletion("", "color")
  local all_colors_no_builtins = vim.tbl_filter(function(color)
    return not vim.tbl_contains(builtins, color)
  end, all_colors)
  local current_index = vim.fn.index(all_colors_no_builtins, current_color)
  if current_index == -1 then
    current_index = 1
  end

  vim.notify("Starting color cycle from: " .. all_colors_no_builtins[current_index], vim.log.levels.INFO,
    { title = "Color Cycle" })

  vim.g.color_cycle = {
    enabled = true,
    colors = all_colors_no_builtins,
    index = current_index
  }

  vim.keymap.set("n", "n", cycle_color, { desc = "Next Color Scheme", buffer = true })
  vim.keymap.set("n", "p", function() cycle_color(-1) end, { desc = "Previous Color Scheme", buffer = true })
  vim.keymap.set("n", "s", function() stop_color_cycle() end, { desc = "Stop Color Cycle", buffer = true })
end

vim.keymap.set("n", "<leader>cs", start_color_cycle, { desc = "Next Color Scheme" })
