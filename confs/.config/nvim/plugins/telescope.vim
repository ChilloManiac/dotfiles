Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


function LoadTelescopeExtensions()
lua << EOF
local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.load_extension('dap')
EOF
endfunction

augroup LoadTelescopeExtensions
    autocmd!
    autocmd User PlugLoaded call LoadTelescopeExtensions()
augroup END
