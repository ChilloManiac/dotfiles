Plug 'diepm/vim-rest-console'

function LoadVimRestConsole()
let g:vrc_curl_opts = {
    \ '--connect-timeout' : 10,
    \ '-b': '/tmp/cookiejar',
    \ '-c': '/tmp/cookiejar',
    \ '-i': "",
\}
endfunction

augroup LoadVimRestConsole
    autocmd!
    autocmd User PlugLoaded call LoadVimRestConsole()
augroup END


