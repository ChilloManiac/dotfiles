Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'RRethy/nvim-treesitter-textsubjects'


function LoadTreesitter()
lua << EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>", -- set to `false` to disable one of the mappings
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-m>",
    },
  },
  textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
        },
    },
}

EOF
endfunction

augroup LoadTreesitter
    autocmd!
    autocmd User PlugLoaded call LoadTreesitter()
augroup END
