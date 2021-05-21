syntax enable


set guicursor=
set mouse=a
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=0
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

if !exists('g:vscode')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mbbill/undotree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'stsewd/fzf-checkout.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'gruvbox-community/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'mcchrish/nnn.vim'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-dispatch'
  Plug 'mhinz/vim-startify'
  Plug 'tweekmonster/gofmt.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'mhartington/oceanic-next'
  source ~/.config/nvim/coc-extensions.vim 
endif

Plug 'vim-utils/vim-man'
Plug 'sheerun/vim-polyglot'
Plug 'rbgrouleff/bclose.vim'
Plug 'justinmk/vim-sneak'
Plug 'szymonmaszke/vimpyter'

call plug#end()


" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

let g:vim_be_good_log_file = 1

" ColorScheme
colorscheme OceanicNext
highlight LineNr guifg=#D8DEE9
highlight Comment guifg=#D08770


if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
tnoremap <Esc> <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap X "_d

inoremap jj <esc>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <silent><expr> <C-space> coc#refresh()


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank(timeuout = 200)
augroup END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" VoidPaste
vnoremap <leader>p "_dp
" yank to clipboard
vnoremap <leader>y "+y



" Sneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S


" QuickEdits
command! EditInit edit ~/.config/nvim/init.vim
command! EditExt edit ~/.config/nvim/coc-extensions.vim
command! EditCoc edit ~/.config/nvim/coc_config.vim

" Dependencies
if !exists('g:vscode')
  " Sweet Sweet FuGITive
  nmap <leader>gj :diffget //3<CR>
  nmap <leader>gf :diffget //2<CR>
  nmap <leader>gs :G<CR>

  " Startify
  let g:startify_list_order = ["dir", "files", "bookmarks", "sessions"]

  " dotnet fsi
  vnoremap <leader>df :CocCommand fsharp.evaluateSelection<CR>

  " Ranger
  map fr <Ranger><CR>

  source ~/.config/nvim/coc_config.vim
endif
