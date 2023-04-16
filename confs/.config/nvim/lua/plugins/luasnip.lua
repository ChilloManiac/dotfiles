local M = {
	"L3MON4D3/LuaSnip",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
	},
}

M.config = function()
	local ls = require("luasnip")
	--
	-- some shorthands...
	local s = ls.snippet
	local sn = ls.snippet_node
	local t = ls.text_node
	local i = ls.insert_node
	local f = ls.function_node
	local c = ls.choice_node
	local d = ls.dynamic_node
	local r = ls.restore_node
	local l = require("luasnip.extras").lambda
	local rep = require("luasnip.extras").rep
	local p = require("luasnip.extras").partial
	local m = require("luasnip.extras").match
	local n = require("luasnip.extras").nonempty
	local dl = require("luasnip.extras").dynamic_lambda
	local fmt = require("luasnip.extras.fmt").fmt
	local fmta = require("luasnip.extras.fmt").fmta
	local types = require("luasnip.util.types")
	local conds = require("luasnip.extras.conditions")
	local conds_expand = require("luasnip.extras.conditions.expand")

	-- If you're reading this file for the first time, best skip to around line 190
	-- where the actual snippet-definitions start.

	-- Every unspecified option will be set to the default.
	ls.setup({
		snip_env = {
			s = function(...)
				local snip = ls.s(...)
				-- we can't just access the global `ls_file_snippets`, since it will be
				-- resolved in the environment of the scope in which it was defined.
				table.insert(getfenv(2).ls_file_snippets, snip)
			end,
			parse = function(...)
				local snip = ls.parser.parse_snippet(...)
				table.insert(getfenv(2).ls_file_snippets, snip)
			end,
			-- remaining definitions.
		},
		history = true,
		-- Update more often, :h events for more info.
		update_events = "TextChanged,TextChangedI",
		-- Snippets aren't automatically removed if their text is deleted.
		-- `delete_check_events` determines on which events (:h events) a check for
		-- deleted snippets is performed.
		-- This can be especially useful when `history` is enabled.
		delete_check_events = "TextChanged",
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "choiceNode", "Comment" } },
				},
			},
		},
		-- treesitter-hl has 100, use something higher (default is 200).
		ext_base_prio = 300,
		-- minimal increase in priority.
		ext_prio_increase = 1,
		enable_autosnippets = true,
		ft_func = require("luasnip.extras.filetype_functions").from_cursor,
	})

	local map = vim.api.nvim_set_keymap

	-- Expand snippet
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end)

	-- Jump forward in snippet
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.jumpable(1) then
			ls.jump(1)
		end
	end, { silent = true })

	-- Jump backward in snippet
	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end, { silent = true })

	-- toggle choices
-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
	-- toggle choices
	vim.keymap.set({ "n" }, "<leader><leader>s", function()
    require("luasnip/loaders/from_lua").load({
      paths = vim.fn.expand("~/.config/nvim/snippets/"),
    })
	end)

	require("luasnip/loaders/from_vscode").lazy_load()
	require("luasnip/loaders/from_snipmate").lazy_load()
	require("luasnip/loaders/from_lua").lazy_load({
		paths = vim.fn.expand("~/.config/nvim/snippets/"),
	})
end

return M

