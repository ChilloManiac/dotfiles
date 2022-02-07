Plug 'terrortylor/nvim-comment'

function LoadCommentConfig()
lua << EOF
require('nvim_comment').setup({
    line_mapping = "",
    operator_mapping= ""
})
EOF
endfunction

augroup LoadCommentConfig
    autocmd!
    autocmd User PlugLoaded call LoadCommentConfig()
augroup END
