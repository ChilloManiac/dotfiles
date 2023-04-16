Plug 'vim-test/vim-test'

function LoadVimTestExtension()

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>

let g:test#strategy = "neovim"

endfunction

augroup LoadVimTestExtension
    autocmd!
    autocmd User PlugLoaded call LoadVimTestExtension()
augroup END
