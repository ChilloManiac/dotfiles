" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#A3BE8C' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#BF616A' gui=underline ctermfg=81 cterm=underline

let g:qs_max_chars=150

" Set on colorscheme changes
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#A3BE8C' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#BF616A' gui=underline ctermfg=81 cterm=underline

augroup END
