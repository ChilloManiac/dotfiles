Plug 'dense-analysis/ale'


function LoadAle()
" let g:ale_fixers = {
" \   'javascript': ['prettier', 'eslint'],
" \   'javascriptreact': ['prettier', 'eslint'],
" \   'typescript': ['prettier', 'eslint'],
" \   'typescriptreact': ['prettier', 'eslint'],
" \   'css': ['prettier'],
" \   'scss': ['prettier'],
" \}
" 
" let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1 

endfunction

augroup LoadAle
    autocmd!
    autocmd User PlugLoaded call LoadAle()
augroup END
