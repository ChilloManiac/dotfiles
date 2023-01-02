Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'


function MasonConfig()
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
EOF
endfunction

augroup MasonConfig
    autocmd!
    autocmd User PlugLoaded call MasonConfig()
augroup END
