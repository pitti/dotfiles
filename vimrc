" My vimrc

" Vundle plugin to handle vim plugins as modules.

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'FSwitch'
Bundle 'scrooloose/nerdtree.git'
" Bundle 'kogakure/vim-sparkup'
Bundle 'vim-scripts/VisIncr.git'
Bundle 'taglist.vim'
Bundle 'Align'
" Bundle 'Schmallon/clang_complete'
Bundle 'nelstrom/vim-visual-star-search.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-markdown.git'
" Bundle 'msanders/snipmate.vim.git'
Bundle 'oinksoft/proj.vim'
Bundle 'jcf/vim-latex'
Bundle 'beloglazov/vim-online-thesaurus'

" Colorschemes
Bundle 'nanotech/jellybeans.vim'
Bundle 'sjl/badwolf'
Bundle 'w0ng/vim-hybrid'
Bundle 'chriskempson/vim-tomorrow-theme'


if v:version > 703 || (v:version == 703 && has('patch584'))
  Bundle 'Valloric/YouCompleteMe'
endif

" Text settings
" ------------------------------------

set textwidth=72
set encoding=utf8

set expandtab     " Expand tabs to spaces
set shiftwidth=2  " Indent depth (number of spaces for indenting)
set tabstop=2     " How many spaces does a tab cover?
set softtabstop=2 " Number of spaces a tab covers while editing


" No syntax error checking on tex files
let g:tex_no_error = 1


" Enable syntax and ft plugins after vundle invocation
syntax on
filetype plugin indent on



" Look and feel settings
" ------------------------------------

set backspace=2  " backspace everything
set hidden       " Allow hidden buffers
set history=50   " Keep 50 lines of command line history
set hlsearch     " Highlight search terms
set ignorecase   " Case-insensitive search default
set smartcase    " Case-sensitive search when using upper-case letters
set laststatus=2 " Always show status line
set linebreak    " Break lines between words, not chars
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
set modeline
set modelines=1

set smartindent

set viminfo='20,<50 " Globally remember last 20 marks and 50 register lines

let mapleader = ","

" Enable the representation of special chars
set listchars=tab:»\ ,eol:¬,trail:·
set list

" set t_Co=256 " Use 256 colors.
set background=dark
colorscheme hybrid


" Check for existance in case we use an older version of vim
if exists('+colorcolumn')
  set colorcolumn=+1 " Highlight column after textwidth
  hi ColorColumn ctermbg=black guibg=black
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


" Tags options
" ------------------------------------

" search for `tags` file from $PWD up to /
set tags=tags;/


" Spell options
" ------------------------------------

set spelllang=de_de " Spellcheck settings (default german)
set sps=best,10     " Show only ten suggestions when spell checking a word

" Active languages for spell checking
let g:myLangList = [ "nospell", "de_de", "en_gb" , "en_us" ]



" Plugin-specific settings
" ------------------------------------

" Taglist options
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select         = 1
let Tlist_Compact_Format          = 0
let Tlist_Display_Tag_Scope       = 0
let Tlist_Inc_Winwidth            = 1
let Tlist_Use_Right_Window        = 1
let Tlist_WinWidth                = 60


" CtrlP options
let g:ctrlp_clear_cache_on_exit = 0


" Key mappings
" ------------------------------------

" Get rid of annoying mappings
map <F1> <Nop>
map K    <Nop>

" Re-select text when using indent commands in visual mode
vnoremap < <gv
vnoremap > >gv

" toggle between normal and paste mode (to avoid automatic indent)
set pastetoggle=<F8>

" Misc mappings
nnoremap <F2> :call <SID>MySpellLang()<CR>
nnoremap <F3> :set cursorline!<CR>

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
nnoremap <silent> <Leader>w :call <SID>StripTrailingWhitespaces()<CR>


" Mappings for text handling
vnoremap Q gq
nnoremap <Leader>q gqip

" Map C-A to replace all occurences of word below cursor
nmap <C-A> :%s/\<<c-r>=expand("<cword>")<cr>\>/


" <Ctrl-B> starts CtrlP plugin in the MRU mode
nnoremap <c-b> :CtrlPMRU<cr>

" Auto commands
" ------------------------------------

augroup resize
	" Resize splits when the whole window is resized
	au! VimResized * exe "normal! \<c-w>="
augroup END

augroup filetype
  au! BufRead,BufNewFile *.ll  set filetype=llvm
  au! BufRead,BufNewFile *.td  set filetype=tablegen
  au! BufRead,BufNewFile *.oct set filetype=octave
augroup END



" Functions
" ------------------------------------

let g:myLang = 0
function! s:MySpellLang()
	let g:myLang = g:myLang + 1
	if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
	if g:myLang == 0
		set nospell
	else
		execute "set spell spelllang=".g:myLangList[g:myLang]
	endif
	echo "language:" g:myLangList[g:myLang]
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


if filereadable("~/.vimrc.local")
	source ~/.vimrc.local
endif


let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_conf.py'

" vim: set tabstop=2 :
