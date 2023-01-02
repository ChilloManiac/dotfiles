Plug 'terrortylor/nvim-comment'

function LoadCommentConfig()
lua << EOF
require('nvim_comment').setup({
    line_mapping = "<C-/>",
    operator_mapping= "<C-/>"
})
EOF
endfunction

augroup LoadCommentConfig
    autocmd!
    autocmd User PlugLoaded call LoadCommentConfig()
augroup END
