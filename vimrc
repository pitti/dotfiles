"my vimrc settings listed alphabetically. Alot of it is shamlessly ripped from
"varius pvv sources :P

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

syntax on
filetype plugin on
filetype plugin indent on

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

" Default Rechtschreibprüfung
" set spell
set nocp

" Deutsche Rechtschreibprüfung
" de* Spell Files Download: http://ftp.vim.org/vim/runtime/spell/
set spelllang=de

" set spellfile=/home/lothar/.vim/de.add

" Rechtschreibprüfung ein- ausschalten mit F2
map <F2> :set spell!<CR><Bar>:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)<CR>

" Nur Top 10 (Rechtschreibprüfung) anzeigen
set sps=best,10

" Highlight cursorline ein- ausschalten mit F3
map <F3> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>

" Kein blinkender Cursor
set gcr=a:blinkon0

set shellslash

" Kein Vi-kompatibler Modus
set nocompatible

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

" Backup-File anlegen
" set backup

" Pfad zum Backup-Verzeichnis
" set backupdir=~/vim

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

" Abkürzungen {{{

ab mfg Mit freundlichen Grüßen,<CR>Philipp Ittershagen

ab vgl Viele Grüße,<CR>Philipp

ab gl Gruß,<CR>Philipp

" Zeitstempel - Mit 02 Feb 2005
iab  mdyl  <c-r>=strftime("%a %d %b %Y")
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


autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
map <F8> :NERDTreeToggle<c-m>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" set t_Co=256
"
set guifont=Terminus\ 8

set tags=tags;/

set tags+=/usr/src/linux/tags

let g:Tex_SmartQuoteOpen = '"`'
let g:Tex_SmartQuoteClose = "\"'"

