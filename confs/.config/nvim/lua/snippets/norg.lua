require("luasnip.session.snippet_collection").clear_snippets "norg"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("norg", {
  s("code", fmt([[
  @code {}
    {}
  @end
  {}
  ]], { i(1, 'language'), i(2, "code goes here"), i(0) })),

  s("chechbox", fmt("- ( ) {}", { i(1, 'todo...') }))
})
