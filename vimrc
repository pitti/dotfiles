" My vimrc

set nocompatible

" Vundle plugin to handle vim plugins as modules.

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'Raimondi/delimitMate'
Bundle 'FSwitch'
Bundle 'scrooloose/nerdtree.git'
Bundle 'kogakure/vim-sparkup'
Bundle 'vim-scripts/VisIncr.git'
Bundle 'taglist.vim'
Bundle 'Align'
Bundle 'Rip-Rip/clang_complete'
Bundle 'nanotech/jellybeans.vim'
Bundle 'nelstrom/vim-visual-star-search.git'


" Enable syntax and ft plugins after vundle invocation
syntax on
filetype plugin indent on


" Look and feel settings
" ------------------------------------

set backspace=2  " backspace everything
set hidden       " Allow hidden buffers
set history=50   " Keep 50 lines of command line history
set hlsearch     " Highlight search terms
set smartcase    " Case-insensitvice search unless upper-case letters
set laststatus=2 " Always show status line
set linebreak    " Break linesa between words, not chars
set incsearch    " Search while typing
set ruler        " Show the cursor position all the time
set scrolloff=2  " Keep 2 lines above and beyond the cursor while scrolling
set scrolljump=5 " Keep 5 lines when jumping towards top or bottom edges
set shortmess=aI " Use short file type descriptions and turn off intro text
set showmode     " Show active mode
set showmatch    " Briefly jump to matching bracket when inserting one
set number       " Show line numbers
set nofen        " Disable folding
set nojoinspaces " Put a space between two joined lines ending with ., ? or !
set title        " Show file name in window title
set autoread     " Read changes automatically when file changes on disk

" GUI-specific options
" ------------------------------------
if has("gui_running")
	" Save when losing focus
	au FocusLost * :w

	" No blinking cursor
	set gcr=a:blinkon0

	" a  selected text in visual mode equals to X11 select-clipboard
	" g  mark inactive menu items grey
	" i  use a vim icon for the window
	" t  tearoff menu items
	" m  enable menu bar
	set guioptions=agitm
endif

set viminfo='20,<50 " Globally remember last 20 marks and 50 register lines

" Enable the representation of special chars
set listchars=tab:»\ ,eol:¬,trail:·
set list

set t_Co=256 " Use 256 colors.
set background=dark
colorscheme jellybeans


" Check for existance in case we use an older version of vim
if exists('+colorcolumn')
	set colorcolumn=+1 " Highlight column after textwidth
endif

" Customize menu for file name expansion (:edit and friends)
set wildmenu
set wildmode=list:longest,list:full

" Ignore some files
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.spl,*.sw?,*.DS_Store

set shellslash " use forward slashes when expanding file names

" status line
" [buffer num] absolute filename  [modified] [RO] [ftype] line,col, percentage
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P


" Text settings
" ------------------------------------

set textwidth=72
set encoding=utf8

set noexpandtab   " Do not expand tabs to spaces
set shiftwidth=2  " Indent depth (number of spaces for indenting)
set tabstop=2     " How many spaces does a tab cover?
set softtabstop=2 " Number of spaces a tab covers while editing



" tags options
" ------------------------------------

" search for `tags` file from $PWD up to /
set tags=tags;/




" Spell options
" ------------------------------------

set spelllang=de_de " Spellcheck settings (default german)
set sps=best,10     " Show only ten suggestions when spell checking a word

" Active languages for spell checking
let g:myLangList = [ "nospell", "de_de", "en_us" ]



" Plugin-specific settings
" ------------------------------------


" Taglist options
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select         = 1
let Tlist_Compact_Format          = 1
let Tlist_Display_Tag_Scope       = 1
let Tlist_Inc_Winwidth            = 1
let Tlist_Use_Right_Window        = 1


" vim-latexsuite options
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf        = 'evince'
let g:tex_indent_items        = 1

" Use german quote style in TeX sources
let g:Tex_SmartQuoteOpen  = '"`'
let g:Tex_SmartQuoteClose = "\"'"

" Command-T options
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight          = 50


" clang_complete options
let g:clang_complete_copen = 1
let g:clang_close_preview  = 1
let g:clang_complete_auto  = 1
let g:clang_hl_errors      = 0


" Key mappings
" ------------------------------------


" Get rid of annoying mappings
map <F1> <Nop>
map K    <Nop>

" Center screen on search result
noremap n nzz

" Re-select text when using indent commands in visual mode
vnoremap < <gv
vnoremap > >gv

" toggle between normal and paste mode (to avoid automatic indent)
set pastetoggle=<F8>

" Misc mappings
nnoremap <F2> :call <SID>MySpellLang()<CR>
nnoremap <F3> :set cursorline!<CR>
nnoremap <F4> :call <SID>ToggleLongLineMatch()<CR>

" Unset search highlight with <c-L>
noremap <silent> <c-l> :silent nohl<cr>

" Use :w!! when editing a file and forgot to sudo
cmap w!! w !sudo tee % >/dev/null

" Buffer and tab handling
nnoremap <silent> <C-c> :bd<CR>
nnoremap <silent> <C-x> :q<CR>
nnoremap <silent> <C-w><C-t> :tabnew .<CR>

" Plugin or function invocations
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
nnoremap <silent> <C-F5> :call <SID>StripTrailingWhitespaces()<CR>

nmap <silent> <Leader>of :FSHere<cr>

nnoremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


" Mappings for text handling
vnoremap Q gq
nnoremap <Leader>q gqip

" Map C-A to replace all occurences of word below cursor
nmap <C-A> :%s/\<<c-r>=expand("<cword>")<cr>\>/


" Auto commands
" ------------------------------------

augroup enhance_syntax
	" Add highlighting for function definition in C++
	autocmd Syntax cpp call <SID>AddFunctionHighlight()
augroup END

augroup filetype
	autocmd! BufRead,BufNewFile *.ll set filetype=llvm
	autocmd! BufNewFile *.{h,hpp} call <SID>insert_gates()
	autocmd! BufEnter   *.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = '.'
augroup END

augroup resize
	" Resize splits when the whole window is resized
	au VimResized * exe "normal! \<c-w>="
augroup END


" Functions
" ------------------------------------

let g:myLang = 0
function! s:MySpellLang()
  " Loop through languages
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=de_de | endif
  if g:myLang == 2 | setlocal spell spelllang=en_us | endif
  echo "language:" g:myLangList[g:myLang]
endfunction


function! s:AddFunctionHighlight()
	syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
	hi def link cppFuncDef Special
endfunction


function! s:StripTrailingWhitespaces()
	" Save last search and cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	" Restore search and cursor position
	let @/=_s
	call cursor(l, c)
endfunction


" insert header gates
function! s:insert_gates()
	let suffix = "_INCLUDED_"
	let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g") . suffix
	execute "normal! i#ifndef " . gname
	execute "normal! o#define " . gname
	execute "normal! Go#endif // " . gname
	normal! k
endfunction


function! s:ToggleLongLineMatch()
	if exists('w:long_line_match')
		call matchdelete(w:long_line_match)
		unlet w:long_line_match
	elseif &textwidth > 0
		let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1)
	else
		let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1)
	endif
endfunction

" vim: set tabstop=2 :
