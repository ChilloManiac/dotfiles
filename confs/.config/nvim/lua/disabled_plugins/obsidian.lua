local M = {
	"epwalsh/obsidian.nvim",
	dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
	},
  keys = {
    { '<leader>os', ':ObsidianSearch<CR>', desc = "ObsidianSearch" },
    { '<leader>ot', ':ObsidianToday<CR>', desc = "ObsidianToday" },
    { '<leader>oy', ':ObsidianYesterday<CR>', desc = "ObsidianToday" },
    { '<leader>on', ':ObsidianNew', desc = "ObsidianNew" },
  },
  enabled = false,
}

M.config = function()
	vim.keymap.set("n", "gf", function()
		if require("obsidian").util.cursor_on_markdown_link() then
			return "<cmd>ObsidianFollowLink<CR>"
		else
			return "gf"
		end
	end, { noremap = false, expr = true })

	require("obsidian").setup({
		dir = "~/obsidian-vault",
		completion = {
			nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
		},
	})
end

return M
