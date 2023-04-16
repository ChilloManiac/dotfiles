-- Lazy load packages
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- this just needs to be fore lazy
vim.g.mapleader = " "

require("lazy").setup({
	{ import = "plugins" },
	"github/copilot.vim",
}, {
	lazy = true,
	checker = {
		enabled = false,
	},
})
