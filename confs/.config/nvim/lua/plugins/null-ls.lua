local M = {
	"nvimtools/none-ls.nvim",
	event = { "VeryLazy" },
	dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			-- null_ls.builtins.diagnostics.tsc
			null_ls.builtins.diagnostics.terraform_validate,
		},
	})
end

return M
