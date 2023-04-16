local M = {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
  events = { "BufReadPre" },
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},

		-- Autocompletion
		{ "hrsh7th/nvim-cmp", events = { "InsertEnter" } },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
	},
}

M.config = function()
	require("neodev").setup()

	local lsp = require("lsp-zero").preset({})
	local lspconfig = require("lspconfig")

	lsp.ensure_installed({
		"cssls",
		"html",
		"vimls",
		"pyright",
		"rust_analyzer",
		"tsserver",
		"tailwindcss",
		"yamlls",
		"graphql",
		"fsautocomplete",
		"eslint",
		"lua_ls",
		"jsonls",
		"terraformls",
		"clangd",
	})

	-- Fix Undefined global 'vim'
	lsp.configure("lua_ls", {
		settings = {
			Lua = {
				completion = {
					callSnipper = "Replace",
				},
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	lsp.configure("graphql", {
		root_dir = lspconfig.util.root_pattern(
			"package.json",
			"yarn.lock",
			".git"
		),
	})

	lsp.configure("eslint", {
		root_dir = lspconfig.util.root_pattern(
			"package.json",
			"yarn.lock",
			".git"
		),
	})

	lsp.configure("efm", {
		filetypes = {
			"elixir",
			"javascript",
			"typescript",
			"lua",
			"sql",
		},
	})

	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_mappings = lsp.defaults.cmp_mappings({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	})

	cmp_mappings["<Tab>"] = nil
	cmp_mappings["<S-Tab>"] = nil

	lsp.setup_nvim_cmp({
		mapping = cmp_mappings,
	})

	lsp.set_preferences({
		set_lsp_keymaps = true,
		manage_nvim_cmp = true,
		suggest_lsp_servers = false,
		sign_icons = {
			error = "E",
			warn = "W",
			hint = "H",
			info = "I",
		},
	})

	lsp.on_attach(function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end)

	-- (Optional) Configure lua language server for neovim
	require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

	lsp.setup()
end

return M
