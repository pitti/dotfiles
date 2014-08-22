" set guifont=ProggyCleanTT\ 12
"set guifont=Droid\ Sans\ Mono\ Slashed\ 9
set guifont=Terminus\ 10

" highlight lines with >120 chars.
" highlight OverLength ctermbg=red ctermfg=white guibg=#4a1111
" match OverLength /\%120v.*/

" Save when losing focus
" au FocusLost * :w

" No blinking cursor
set gcr=a:blinkon0

" a  selected text in visual mode equals to X11 select-clipboard
" g  mark inactive menu items grey
" i  use a vim icon for the window
" t  tearoff menu items
" m  enable menu bar
set guioptions=agitm
