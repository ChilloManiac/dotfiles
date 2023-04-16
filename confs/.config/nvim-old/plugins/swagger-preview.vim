Plug 'vinnymeller/swagger-preview.nvim'

function LoadSwaggerPreview()
lua << EOF
require("swagger-preview").setup({
    -- The port to run the preview server on
    port = 8000,
    -- The host to run the preview server on
    host = "localhost",
})
EOF
endfunction

augroup LoadSwaggerPreview
    autocmd!
    autocmd User PlugLoaded call LoadSwaggerPreview()
augroup END
