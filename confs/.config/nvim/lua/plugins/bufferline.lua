local tabname_format = function(opts)
	return string.format("%s.", opts.ordinal)
end

local M = {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			always_show_bufferline = true,
			numbers = tabname_format,
			show_buffer_icons = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			separator_style = "thin",
			-- Don't show bufferline over vertical, unmodifiable buffers
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
				},
			},
			highlights = { buffer_selected = { bold = true } },
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}

return M
