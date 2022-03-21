Plug 'jose-elias-alvarez/null-ls.nvim'

function LoadNullLs()
lua << EOF
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier_d_slim,
        require("null-ls").builtins.diagnostics.eslint,
    },
})
EOF
endfunction

augroup LoadNullLs
    autocmd!
    autocmd User PlugLoaded call LoadNullLs()
augroup END
