local M = {
	"kyazdani42/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
	},
  opts = {
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
  }
}

return M
