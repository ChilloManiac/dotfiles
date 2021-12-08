Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


function LoadTelescopeExtensions()
lua << EOF
require('telescope').load_extension('fzf')
EOF
endfunction

augroup LoadTelescopeExtensions
    autocmd!
    autocmd User PlugLoaded call LoadTelescopeExtensions()
augroup END
