local M = {
	"nvim-telescope/telescope.nvim",
	version = "0.1.x",
	dependencies = { { "nvim-lua/plenary.nvim" } },
}

M.config = function()
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
	vim.keymap.set("n", "<C-p>", builtin.git_files, {})
	vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end)
	vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

	require("telescope").setup({
		defaults = {
			sorting_strategy = "ascending",
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-c>"] = actions.close,
				},
				n = {
					["<C-c>"] = actions.close,
				},
			},
			layout_config = {
				horizontal = {
					height = 47,
					prompt_position = "bottom",
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end

return M
