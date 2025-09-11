vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
  "https://github.com/aaronik/treewalker.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("nvim-treesitter.configs").setup({
  auto_install = true,
  ensure_installed = {},
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "+",
      scope_incremental = "gnn",
      node_decremental = "-",
    }
  }
})

vim.keymap.set("n", "+", "v", { noremap = true, silent = true })

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Handle nvim-treesitter updates',
  group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
  callback = function(event)
    if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
      vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, 'TSUpdate')
      if ok then
        vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
      else
        vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
      end
    end
  end,
})


require('treewalker').setup({
  highlight = false
})
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>zz', { silent = true, desc = "Move up in Treewalker" })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>zz',
  { silent = true, desc = "Move down in Treewalker" })
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>zz',
  { silent = true, desc = "Move right in Treewalker" })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>zz',
  { silent = true, desc = "Move left in Treewalker" })

vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>zz',
  { silent = true, desc = "Swap down in Treewalker" })
vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>zz', { silent = true, desc = "Swap up in Treewalker" })
vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<CR>zz',
  { silent = true, desc = "Swap right in Treewalker" })
vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<CR>zz',
  { silent = true, desc = "Swap left in Treewalker" })

require("treesitter-context").setup({})
