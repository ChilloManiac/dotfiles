local M = {
  'preservim/nerdtree',
  depends = { 'Xuyuanp/nerdtree-git-plugin', 'tiagofumo/vim-nerdtree-syntax-highlight' },
  config = function()

    vim.g.NERDTreeShowHidden = 1
    vim.g.NERDTreeMinimalUI = 1
    vim.g.NERDTreeCascadeSingleChildDir = 0

    vim.g.NERDTreeDirArrowExpandable = '▹'
    vim.g.NERDTreeDirArrowCollapsible = '▿'
    vim.g.NERDTreeIgnore = { '__pycache__$', '^__init__.py$' }

    vim.keymap.set('n', '<leader>n', ':NERDTreeFind<CR>', { silent = true, noremap = true})
    vim.keymap.set('n', '<leader>N', ':NERDTreeFocus<CR>', { silent = true, noremap = true})

    vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
    vim.g.DevIconsEnableFoldersOpenClose = 1
    vim.g.DevIconsEnableFolderExtensionPatternMatching = 1
  end


}

return M
