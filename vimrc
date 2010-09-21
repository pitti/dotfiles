" vimrc. most things ripped from other vimrcs.

set encoding=utf8
set backspace=2 " backspace  everything
set grepprg=grep\ -nH\ $*
set guioptions=agitm
set hidden
set history=50 " keep 50 lines of command line history
set hlsearch
set ignorecase smartcase "case-insensitvice search unless upper-case letters
set laststatus=2
set lazyredraw
set linebreak
set incsearch " do incremental searching
set modeline
set nocompatible
set noexpandtab
set ruler " show the cursor position all the time
set scrolloff=2
set scrolljump=5
set shortmess=aI "avoid anoyting hit ENTER stuff at prompt
set showcmd " display incomplete commands
set showmode
set showmatch
set softtabstop=2
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P
set timeoutlen=500
set wildmenu
set wildmode=list:longest,full
set shellslash
set modelines=1
set list
set listchars=tab:→\ ,extends:>,precedes:<
highlight SpecialKey ctermfg=243 guibg=black
" highlight NonText ctermfg=243 guifg=darkgray
let mapleader = ","
syntax on
set number

" No blinking cursor
set gcr=a:blinkon0

" Fold method.
" marker: use {{{ and }}} to indicate a fold
" syntax: fold functions etc
" set foldmethod=syntax

" Indent automatically
set smartindent
" set cindent

" Indent depth
set shiftwidth=2

" How many spaces does a tabstop cover?
set tabstop=2

" Use F8 to toggle between normal and paste mode (to avoid automatic indent
" while pasting)
set pastetoggle=<F8>

" Put a space between two joined lines ending with ., ? or !
set nojoinspaces

" Show file name in window title.
set title

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$/VIM/vimfiles/after,~/.vimr/after

set viminfo='20,\"50

filetype plugin on
filetype plugin indent on

" Spellcheck settings
set spelllang=de
let spell_auto_type = "tex,mail"
let spell_language_list = "english,german"
let spell_executable ="aspell"
map <F2> :set spell!<CR><Bar>:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)<CR>

" Show only ten suggestions when spell checking a word
set sps=best,10

" Taglist options
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format = 1
let Tlist_Display_Tag_Scope = 1
let Tlist_Inc_Winwidth = 1

" Vim-LaTeX related stuff
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'

" Switch to the path when editing a file
autocmd BufEnter * lcd %:p:h

" Center screen on search result
nmap n nzz

vnoremap < <gv
vnoremap > >gv

" Delete Buffer from Session with Ctrl-C
nnoremap <silent> <C-c> :bd<CR>
"
" Close Buffer with Ctrl-X
nnoremap <silent> <C-x> :q<CR>

" Use registers more intelligent
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Open taglist with F8
nnoremap <silent> <F8> :TlistToggle<CR>

" Use <c-tab> <shift-c-tab> to switch between tabs
nnoremap <silent> <C-TAB> :tabn<CR>
nnoremap <silent> <C-S-TAB> :tabp<CR>

" removes whitespaces at the end of lines
nnoremap <silent> <C-F5> :call <SID>StripTrailingWhitespaces()<CR>

" Issue make
map <silent> <F6> :w<CR>:make -j2<CR>

" Close and move to prev / next file using F10 / F11
map <F10> :cp<CR>
map <F11> :cn<CR>

" Easy formatting of text
map Q gq

" <C-F12> for ctags file
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Auto highlight funtions below cursor
map <F7> :call Auto_Highlight_Toggle()<CR>

" Map C-A to replace all occurences of word below cursor
nmap <C-A> :%s/\<<c-r>=expand("<cword>")<cr>\>/

" Highlight cursorline
map <F3> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>

" Mappings

" Unset search highlight with <c-L>
map <silent> <c-l> :silent nohl<cr>


" Fold highlight color
" hi Folded ctermbg=black ctermfg=cyan

" Statusline color
hi StatusLine cterm=bold,reverse

" search for `tags` file from $PWD to /
set tags=tags;/

" special tags place(s)
set tags +=~/.vim/tags/cpp
set tags +=~/.vim/tags/linux
set tags +=/usr/src/linux/tags
set tags +=/home/klmann/ml410/linux-2.6-xlnx/tags


" Use german quotes in TeX sources
let g:Tex_SmartQuoteOpen = '"`'
let g:Tex_SmartQuoteClose = "\"'"

" :;tf is for operations only between { and }
:cmap ;tf ?^{??(?,/^}/

" insert closing brace when typing {
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O

" avoid nasty double-braces by defining extra rules for them
inoremap {{     {
inoremap {}     {}

" the same, with ()

inoremap (      ()<Left>
inoremap ((     (
inoremap ()     ()


" insert #ifndef FILE_H_INCLUDED_, #define ...  when opening a new header file
function! s:insert_gates()
	let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g") . "_INCLUDED_"
	execute "normal! i#ifndef " . gatename
	execute "normal! o#define " . gatename . " "
	execute "normal! Go#endif /* " . gatename . " */"
	normal! k
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

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

" Enable FSwitch plugin for fast switching between .h and .c files
au! BufEnter *.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = '.'

" Map the FSwitch plugin functions
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oh :FSLeft<cr>

autocmd BufWritePre *.{c,cc,cpp,h,hpp} :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
	" save last search and cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	" restore search and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

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

" highlight lines with >80 chars.
highlight OverLength ctermbg=red ctermfg=white guibg=#4a1111
match OverLength /\%120v.*/



" source kernel specific things when editing kernel-specific files ;) 
autocmd BufRead,BufNewFile /home/klmann/ml410/ba-code/driver/* so /home/klmann/ml410/linux-2.6-xlnx/vimrc-kernel
