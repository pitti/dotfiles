colorscheme ir_black
set guifont=Inconsolata\ 8

" highlight lines with >120 chars.
highlight OverLength ctermbg=red ctermfg=white guibg=#4a1111
match OverLength /\%120v.*/
highlight SpecialKey ctermfg=243 guibg=black
" highlight NonText ctermfg=243 guifg=darkgray
