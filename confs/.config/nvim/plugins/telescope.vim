Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


function LoadTelescopeExtensions()
lua << EOF
local telescope = require('telescope')
telescope.load_extension('fzf')
EOF
endfunction

augroup LoadTelescopeExtensions
    autocmd!
    autocmd User PlugLoaded call LoadTelescopeExtensions()
augroup END
