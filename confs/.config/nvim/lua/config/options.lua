vim.opt.expandtab = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes:2"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spell = false
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.scrolloff = 12
vim.opt.sidescrolloff = 12
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true
vim.opt.updatetime = 300
vim.opt.redrawtime = 10000
vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 4
vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 4
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.winwidth = 120
vim.opt.winminwidth = 30
vim.opt.background = "dark"
vim.opt.winborder = "none"
vim.diagnostic.config({
  virtual_lines = false,
  jump = {
    float = {
      enabled = true,
    },
  },
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
    prefix = "●",
    spacing = 4,
  },
})

function FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  return line .. " "
end

vim.o.foldtext = "v:lua.FoldText()"

vim.g.is_github_cli = vim.fn.environ()["IS_GH_CLI"] == "1"
