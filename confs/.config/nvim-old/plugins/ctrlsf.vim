Plug 'dyng/ctrlsf.vim'

function LoadCtrlsfExtensions()
nnoremap <leader>fs <Plug>CtrlSFPrompt
nnoremap <leader>ct :CtrlSFToggle<CR>
endfunction

augroup LoadCtrlsfExtensions
    autocmd!
    autocmd User PlugLoaded call LoadCtrlsfExtensions()
augroup END
