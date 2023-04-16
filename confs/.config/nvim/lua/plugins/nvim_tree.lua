local M = {
	"kyazdani42/nvim-tree.lua",
	cmd = "NvimTreeToggle",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<leader>`", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
	},
}

M.config = function()
	-- OR setup with some options
	require("nvim-tree").setup({
		sort_by = "case_sensitive",
		view = {
			adaptive_size = true,
		},
		renderer = {
			group_empty = true,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
	})
end

return M
