" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Adjusted for llvm layout
augroup myrules
    au!
    au BufEnter *.h let b:fwsitchdst = 'cpp,cxx,c'
    au BufEnter *.h let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,../src,reg:/include/lib/'

    au BufEnter *.c,*.cpp let b:fwsitchdst = 'h,hpp'
    au BufEnter *.c,*.cpp let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include,reg:/include/lib/'
augroup END

" insert header gates
function! s:insert_gates()
	let suffix = "_INCLUDED_"
	let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g") . suffix
	execute "normal! i#ifndef " . gname
	execute "normal! o#define " . gname
	execute "normal! Go#endif // " . gname
	normal! ko
endfunction

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


au! BufNewFile *.h call <SID>insert_gates()

set cinoptions+=(0

" clang_complete options
let g:clang_complete_copen = 1
let g:clang_close_preview  = 1
let g:clang_complete_auto  = 1
let g:clang_hl_errors      = 0

nmap <silent> <Leader>of :FSHere<cr>
nnoremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


set fo+=ro

