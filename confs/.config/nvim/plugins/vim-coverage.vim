Plug 'google/vim-maktaba'
Plug 'google/vim-coverage'
Plug 'google/vim-glaive'

function LoadCovExtensions()
call glaive#Install()
endfunction

augroup LoadCovExtensions
    autocmd!
    autocmd User PlugLoaded call LoadCovExtensions()
augroup END
