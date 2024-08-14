local M = {
	"hrsh7th/nvim-cmp",
	event = { "VeryLazy" },
	dependencies = {
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "onsails/lspkind.nvim" },

		-- Snippet engine
		{ "L3MON4D3/LuaSnip" },
	},
}

M.config = function()
	require("luasnip").setup({})

	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local lspkind = require("lspkind")
	local ls = require("luasnip")

	cmp.setup({
		sources = {
			{ name = "luasnip", keyword_length = 2 },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer", keyword_length = 4 },
			{ name = "vim-dadbod-completion" },
			{ name = "neorg" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = nil,
			["<S-Tab>"] = nil,
			["<C-.>"] = cmp.mapping({
				i = function()
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end,
				c = function()
					if cmp.visible() then
						cmp.close()
					else
						cmp.complete()
					end
				end,
			}),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol", -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				-- can also be a function to dynamically calculate max width such as
				-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
				ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				show_labelDetails = true, -- show labelDetails in menu. Disabled by default
			}),
		},
	})

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
	})

	for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
		loadfile(ft_path)()
	end

	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
	end, { silent = true })
end

return M
