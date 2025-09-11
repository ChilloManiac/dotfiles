vim.pack.add({
  "https://github.com/L3MON4D3/LuaSnip"
})

local ls = require("luasnip")
local types = require("luasnip.util.types")
ls.setup({})

-- TJ's luasnippet setup
-- https://github.com/tjdevries/config.nvim/blob/37c9356fd40a8d3589638c8d16a6a6b1274c40ca/lua/custom/snippets.lua

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return ls.expand_or_jumpable()
  else
    return ls.jumpable(filter.direction)
  end
end


---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
  if direction == 1 then
    if ls.expandable() then
      return ls.expand_or_jump()
    else
      return ls.jumpable(1) and ls.jump(1)
    end
  else
    return ls.jumpable(-1) and ls.jump(-1)
  end
end

vim.snippet.stop = ls.unlink_current

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  override_builtin = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "Keyword" } },
        hl_mode = "combine"
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "Comment" } },
        hl_mode = "combine"
      }
    }
  },
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
  loadfile(ft_path)()
end
