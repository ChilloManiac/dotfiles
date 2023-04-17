local M = {
	"nvim-telescope/telescope.nvim",
	version = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{ 'nvim-telescope/telescope-dap.nvim' },
		{ 'nvim-tree/nvim-web-devicons' }
	},
}

M.config = function ()
	local telescope = require('telescope')

	local opts = {noremap = true, silent = true}

	vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', opts)
	vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_files<cr>', opts)
	vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
	vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

	telescope.setup({
    extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
	})
end

return M


