local M = {
	"tpope/vim-fugitive",
	config = function()

		local opts = {noremap = true, silent = true}
		vim.keymap.set('n', '<leader>gf', ':diffget //3<CR>', opts)
		vim.keymap.set('n', '<leader>gj', ':diffget //2<CR>', opts)
		vim.keymap.set('n', '<leader>gs', ':Git<CR>', opts)
	end,
}
return M
