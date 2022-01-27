"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

set expandtab
set shiftwidth=4
set tabstop=4
set signcolumn=yes:2
set relativenumber
set number
set nospell
set termguicolors
set title
set ignorecase
set smartcase
set nowrap
set mouse=a
set scrolloff=8
set sidescrolloff=8
set splitright
set clipboard=unnamedplus
set confirm
set updatetime=300
set redrawtime=10000


"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <leader>k :nohlsearch<CR>
map gf :edit <cfile><CR>

vnoremap y myy`y
vnoremap Y myY`y
vnoremap <leader>p "_dP

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-d> <C-d>zzzv
nnoremap <C-u> <C-u>zzzv

imap jj <esc>

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/floatterm.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/fzf-native.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/nvim-markdown-preview.vim
source ~/.config/nvim/plugins/omnisharp-vim.vim
source ~/.config/nvim/plugins/plantuml.vim
source ~/.config/nvim/plugins/plenary.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/quick-scope.vim
source ~/.config/nvim/plugins/tree-sitter.vim
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/vim-startify.vim
source ~/.config/nvim/plugins/whichkey.vim
call plug#end()
doautocmd User PlugLoaded " Hook to call code after plugins


