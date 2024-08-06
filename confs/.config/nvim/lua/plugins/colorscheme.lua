local M = {
	{ "folke/tokyonight.nvim", lazy = true },
	{ "Mofiqul/dracula.nvim", lazy = true },
	{ "savq/melange-nvim", lazy = true },
	{ "scottmckendry/cyberdream.nvim", lazy = true },
	{ "mhartington/oceanic-next", lazy = true },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme rose-pine-moon")
		end,
	},
}

return M
