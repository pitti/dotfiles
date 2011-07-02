" vimrc. most things ripped from other vimrcs.
filetype off

set encoding=utf8
set backspace=2 " backspace  everything
set grepprg=grep\ -nH\ $*
set guioptions=agitm
set hidden
set history=50 " keep 50 lines of command line history
set hlsearch
set ignorecase smartcase "case-insensitvice search unless upper-case letters
set laststatus=2
" set lazyredraw
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
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P
set timeoutlen=500
set wildmenu
set wildmode=list:longest,full
set shellslash
set modelines=1
let mapleader = ","
syntax on
set number

" Enable the representation of special chars
set listchars=tab:▸\ ,eol:¬,trail:☠
set list

" Everything that gets in the "" register also comes to the OS clipboard (the
" "selection & middle click" clipboard)
set clipboard=unnamed

" No blinking cursor
set gcr=a:blinkon0

" Fold method.
" marker: use {{{ and }}} to indicate a fold
" syntax: fold functions etc
" set foldmethod=syntax

" disable folding
set nofen

" Indent automatically
set smartindent
" set cindent

" Indent depth (number of spaces for indenting)
set shiftwidth=2

" How many spaces does a tab cover?
set tabstop=2
set softtabstop=2

" Use F8 to toggle between normal and paste mode (to avoid automatic indent
" while pasting)
set pastetoggle=<F8>

" Put a space between two joined lines ending with ., ? or !
set nojoinspaces

" Show file name in window title.
set title

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vimr/after

set viminfo='20,\"50


" Blink matching bracket time (10th/s)
set mat=5

" fast TTY
set ttyfast


" auto read changes
set autoread



" vundle plugin to handle vim plugins as modules.

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache.git'
Bundle 'tpope/vim-fugitive'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'Raimondi/delimitMate'
Bundle 'FSwitch'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tmallen/proj-vim.git'
Bundle 'kogakure/vim-sparkup'
Bundle 'vim-scripts/VisIncr.git'
Bundle 'taglist.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Align'

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
let Tlist_Use_Right_Window = 1

" Vim-LaTeX related stuff
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'

" Switch to the path when editing a file
" autocmd BufEnter * lcd %:p:h

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
nnoremap <silent> <F9> :NERDTreeToggle<CR>

" Use <c-tab> <shift-c-tab> to switch between tabs
nnoremap <silent> <C-TAB> :tabn<CR>
nnoremap <silent> <C-S-TAB> :tabp<CR>

" Use <c-t> to open new tab
nnoremap <silent> <C-t> :tabnew .<CR>

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
" set tags +=~/.vim/tags/cpp
" set tags +=~/.vim/tags/linux
set tags +=~/.vim/tags/qt4-gui
set tags +=~/.vim/tags/qt
set tags +=/usr/src/linux/tags
set tags +=/home/klmann/ml410/linux-2.6-xlnx/tags


" Use german quotes in TeX sources
let g:Tex_SmartQuoteOpen = '"`'
let g:Tex_SmartQuoteClose = "\"'"

" :;tf is for operations only between { and }
:cmap ;tf ?^{??(?,/^}/


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

" autocmd BufWritePre *.{tex,java,c,cc,cpp,h,hpp} :call <SID>StripTrailingWhitespaces()

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

" source kernel specific things when editing kernel-specific files ;)
autocmd BufRead,BufNewFile /home/klmann/ml410/ba-code/driver/* so /home/klmann/ml410/linux-2.6-xlnx/vimrc-kernel


" highlight lines with >120 chars.
highlight OverLength ctermbg=red ctermfg=white guibg=#4a1111
match OverLength /\%120v.*/


" Toggle OverLength Highlight with F4
nnoremap <F4> :call <SID>ToggleLongLineMatch()<CR>

function! <SID>ToggleLongLineMatch()
	if exists('w:long_line_match')
		call matchdelete(w:long_line_match)
		unlet w:long_line_match
	elseif &textwidth > 0
		let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1)
	else
		let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1)
	endif
endfunction

" Use :w!! when editing a file and forgot sudo.
cmap w!! w !sudo tee % >/dev/null


" Recognize HySAT files als HySAT filetype
autocmd BufNewFile,BufRead *.hys set filetype=hysat

" Recognize vala filetype
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120


" neocomplcache settings

let g:neocomplcache_snippets_dir = '~/.vim/snippets/'


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" Accept snippets with Ctrl-k
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)

" Pressing <CR> accepts the hightlighted completion
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"


inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


" Use 256 colors.
set t_Co=256

set background=dark
colorscheme molokai2
