" Vundle plugin to handle vim plugins as modules.

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'FSwitch'
" Bundle 'scrooloose/nerdtree.git'
Bundle 'vim-scripts/VisIncr.git'
Bundle 'Align'
Bundle 'nelstrom/vim-visual-star-search.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-markdown.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'beloglazov/vim-online-thesaurus'
Bundle 'rking/ag.vim'
Bundle 'thinca/vim-localrc'
Bundle 'vimoutliner/vimoutliner.git'
Bundle 'Valloric/ListToggle'
Bundle 'rust-lang/rust.vim'

" Colorschemes
" Bundle 'nanotech/jellybeans.vim'
" Bundle 'sjl/badwolf'
Bundle 'w0ng/vim-hybrid'
" Bundle 'chriskempson/vim-tomorrow-theme'
" Bundle 'chriskempson/base16-vim'


" Text settings
" ------------------------------------

set textwidth=72
set encoding=utf8

set expandtab     " Expand tabs to spaces
set shiftwidth=2  " Indent depth (number of spaces for indenting)
set tabstop=2     " How many spaces does a tab cover?
set softtabstop=2 " Number of spaces a tab covers while editing

" Enable syntax and ft plugins after vundle invocation
syntax on
filetype plugin indent on



" Look and feel settings
" ------------------------------------

set backspace=2  " backspace everything
set hidden       " Allow hidden buffers
set hlsearch     " Highlight search terms
set ignorecase   " Default: ignore case sensitivity
set smartcase    " Case-sensitive search when using upper-case letters
set laststatus=2 " Always show status line
set linebreak    " Break lines between words, not chars
set incsearch    " Search while typing
set ruler        " Show the cursor position all the time
set scrolloff=2  " Keep 2 lines above and beyond the cursor while scrolling
set scrolljump=5 " Keep 5 lines when jumping towards top or bottom edges
set shortmess=aI " Use short file type descriptions and turn off intro text
set showmode     " Show active mode
set number       " Show line numbers
set nofen        " Disable folding
set title        " Show file name in window title
set autoread     " Read changes automatically when file changes on disk
set modeline

set completeopt=menuone " Only open the menu when completing, don't show
                        " the preview window

set smartindent

set viminfo='20,<50 " Globally remember last 20 marks and 50 register lines

let mapleader = ","

" Enable the representation of special chars
set listchars=tab:»\ ,eol:¬,trail:·
set list

" set t_Co=256 " Use 256 colors.
set background=dark
colorscheme hybrid


" Check for existence in case we use an older version of vim
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


" CtrlP options
let g:ctrlp_clear_cache_on_exit = 1

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_conf.py'
let g:ycm_always_populate_location_list = 1

" Location List and Quickfix List mappings
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>Q'

" Key mappings
" ------------------------------------

" Get rid of annoying mappings
map <F1> <Nop>
map K    <Nop>
map Q    <Nop>

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

" Plugin or function invocations
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>w :call <SID>StripTrailingWhitespaces()<CR>

" Mappings for text handling
vnoremap Q gq
nnoremap <Leader>q gqip

nnoremap K :OnlineThesaurusCurrentWord<CR>

" Map C-A to replace all occurences of word below cursor
nmap <C-A> :%s/\<<c-r>=expand("<cword>")<cr>\>/

" <Ctrl-B> starts CtrlP plugin in the MRU mode
nnoremap <C-b> :CtrlPMRU<cr>

" bindings for ag (grep-like search)
nmap ´ :Ag <c-r>=expand("<cword>")<cr><cr>

" EOL space on next line desired
nnoremap <space>/ :Ag 

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

" vim: set tabstop=2 :
