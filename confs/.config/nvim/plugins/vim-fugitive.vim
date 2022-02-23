Plug 'tpope/vim-fugitive'

function LoadVimFugitive()
nmap <leader>gf :diffget //3<CR>
nmap <leader>gj :diffget //2<CR>
nmap <leader>gs :Git<CR>

endfunction

augroup LoadVimFugitive
    autocmd!
    autocmd User PlugLoaded call LoadVimFugitive()
augroup END


