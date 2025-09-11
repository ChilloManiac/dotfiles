require("luasnip.session.snippet_collection").clear_snippets "lua"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("lua", {
  s("vpa", {
    t("vim.pack.add({"),
    t({ "", "\t\"https://github.com/" }), i(1, "author/repo"), t("\",", ""),
    t({ "", "\t" }), i(2),
    t({ "", "})" }), i(0),
  })
})
