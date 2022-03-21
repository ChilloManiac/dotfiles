Plug 'sbdchd/neoformat'

function LoadNeoformat()
let g:neoformat_try_node_exe = 1
endfunction

augroup LoadNeoformat
    autocmd!
    autocmd User PlugLoaded call LoadNeoformat()
augroup END
