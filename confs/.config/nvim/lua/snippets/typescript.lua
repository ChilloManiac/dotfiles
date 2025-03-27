require("luasnip.session.snippet_collection").clear_snippets "typescript"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", {
  s("it", fmt([[
  it('{}', async () => {{
    // Arrange
    {}

    // Act
    {}

    // Assert
    {}
  }});
  ]], { i(1, 'should do something'), i(2), i(3), i(0) }))
})
