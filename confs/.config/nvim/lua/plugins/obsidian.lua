local M = {
	"epwalsh/obsidian.nvim",
	dependencies = {
		"preservim/vim-markdown",
		"godlygeek/tabular",
	},
}

M.config = function()
	vim.api.nvim_set_keymap(
		"n",
		"<leader>os",
		":ObsidianSearch<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ot",
		":ObsidianToday<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>on",
		":ObsidianNew<CR>",
		{ noremap = true, silent = true }
	)

	vim.keymap.set("n", "gf", function()
		if require("obsidian").util.cursor_on_markdown_link() then
			return "<cmd>ObsidianFollowLink<CR>"
		else
			return "gf"
		end
	end, { noremap = false, expr = true })

	require("obsidian").setup({
		dir = "~/configs/obsidian-vault",
		completion = {
			nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
		},
	})
end

return M
