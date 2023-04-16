local M = {
	"wesleimp/stylua.nvim",
	config = function()
		vim.keymap.set(
			"n",
			"<leader>lf",
			'<cmd>lua require("stylua").format()<CR>'
		)
	end,
}

return M
