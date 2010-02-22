" TODO: cleanup
" vimrc. most things ripped from other vimrcs.
set ai
set backspace=2 " backspace  everything
set cindent
set foldmethod=syntax
set grepprg=grep\ -nH\ $*
set guioptions=agitm
set hidden
set history=50		" keep 50 lines of command line history
set hlsearch
set ignorecase smartcase "case-insensitvice search unless upper-case letters
set laststatus=2
set lazyredraw
set linebreak
set incsearch		" do incremental searching
set modeline
set nocompatible
set noexpandtab
set ruler		" show the cursor position all the time
set scrolloff=2
set scrolljump=5
set shiftwidth=2
set shortmess=aI "avoid anoyting hit ENTER stuff at prompt
set showcmd		" display incomplete commands
set showmode
set showmatch
set softtabstop=2
set smartcase
set si
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P
set tabstop=2
set timeoutlen=500
" set visualbell
set wildmenu
set wildmode=list:longest,full

let html_use_css=1
let use_xhtml=1
let spell_auto_type = "tex,mail"
let spell_language_list = "english,german"
let spell_executable ="aspell"

" Taglist options
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format = 1
let Tlist_Display_Tag_Scope = 1
let Tlist_Inc_Winwidth = 1

au BufRead,BufNewFile *.phps  set filetype php
autocmd BufEnter * lcd %:p:h

"---------- key mappings -------------------
map Q gq
" center screen on search result
nmap n nzz
"map <c-y> <c-]> "map to move in tagstack on norwegian mac keyb
vnoremap < <gv
vnoremap > >gv
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

"taglist open F8
nnoremap <silent> <F8> :TlistToggle<CR>

nnoremap <silent> <C-TAB> :tabn<CR>
nnoremap <silent> <C-S-TAB> :tabp<CR>
map <F12>  :make<cr>:cw<CR>
map <F10> :cp<CR>
map <F11> :cn<CR>
map Q gq

" Map C-A to replace all occurences of marked word
nmap <C-A> :%s/\<<c-r>=expand("<cword>")<cr>\>/

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'

set shellslash

" Settings {{{

" Deutsche Rechtschreibprüfung
" de* Spell Files Download: http://ftp.vim.org/vim/runtime/spell/
set spelllang=de

" Rechtschreibprüfung ein- ausschalten mit F2
map <F2> :set spell!<CR><Bar>:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)<CR>

" Nur Top 10 (Rechtschreibprüfung) anzeigen
set sps=best,10

" Highlight cursorline ein- ausschalten mit F3
map <F3> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>

" Kein blinkender Cursor
set gcr=a:blinkon0

set shellslash

" Alle Suchtreffer farblich hervorheben
set hlsearch

" Während der Eingabe zum entsprechenden Text springen
set incsearch

" Groß- und Kleinschreibung bei der Suche ignorieren
set ignorecase

" ignorecase abschalten, wenn Muster Großbuchstaben enthält
set smartcase

" Syntax-Highlighting
syntax on

" Zeilennummerierung
set number

" Faltungsmethode = Markierungen - Standardmäßig werden {{{ zum Anfang und }}}
" zum Ende einer Faltung verwendet
set foldmethod=marker

" Automatisches Einrücken
set smartindent

" Einrücktiefe
set shiftwidth=4

set tabstop=4

" Treppeneffekt beim Copy & Paste verhindern
set pastetoggle=<F8>

" Normales Verhalten der Backspace-Taste
set backspace=2

" Zeigt den aktuellen Modus an
set showmode

" Zeigt die aktuelle Cursorposition
set ruler

" Ein Leerzeichen nach .,?,! beim Zusammenfügen von zwei Zeilen
set nojoinspaces

" Statusline - 2 Zeilen hoch
set laststatus=2

" Modeline nur in 1. Zeile zulässig
set modelines=1

" Name der aktuellen Datei in Fenster-Titel-Leiste
set title

" Liste von Verzeichnissen die durchsucht werden
set runtimepath=~/.vim,$VIMRUNTIME

set viminfo='20,\"50

set history=50


" }}}

" Mappings {{{

" Hervorhebungen der Suche mit Strg-L enfernen
map <silent> <c-l> :silent nohl<cr>

" }}}

" Funktionen {{{

" Erzeugt tags-File. Aufruf: :call Ht()
fun! Ht()
	execute "helptags " . expand("%:p:h")
endfun

" }}}

" Syntax {{{

" Folds
hi Folded ctermbg=black ctermfg=cyan

" Statusline
hi StatusLine cterm=bold,reverse

" }}}


" set tags=tags;/
set tags +=~/.vim/tags/cpp
" set tags +=~/.vim/tags/linux
" set tags +=/usr/src/linux/tags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

let g:Tex_SmartQuoteOpen = '"`'
let g:Tex_SmartQuoteClose = "\"'"

" :;tf is for operations on "this function"
:cmap ;tf ?^{??(?,/^}/

" insert closing brace when typing {
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}


" insert #ifndef __HEADER_H, #define ...  when opening a new header file
function! s:insert_gates()
	let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	execute "normal! i#ifndef " . gatename
	execute "normal! o#define " . gatename . " "
	execute "normal! Go#endif /* " . gatename . " */"
	normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

map <F7> :call Auto_Highlight_Toggle()<CR>
map <F6> :silent !make<CR>

function! Auto_Highlight_Cword()
	exe "let @/='\\<".expand("<cword>")."\\>'"
endfunction

function! Auto_Highlight_Toggle()
	if exists("#CursorHold#*")
		au! CursorHold *
		let @/=''
	else
		set hlsearch
		set updatetime=500
		au! CursorHold * nested call Auto_Highlight_Cword()
	endif
endfunction

" highlight lines with >80 chars.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/

filetype plugin on
filetype plugin indent on

set nocp


" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

