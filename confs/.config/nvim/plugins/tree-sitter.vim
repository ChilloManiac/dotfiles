Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

function LoadTreeSitterConfig()
endfunction

augroup LoadTreeSitterConfig
    autocmd!
    autocmd User PlugLoaded call LoadTreeSitterConfig()
augroup END
