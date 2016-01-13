" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" insert header gates
function! s:insert_gates()
	let suffix = "_INCLUDED_"
	let gname = substitute(toupper(expand("@%")), "\\.", "_", "g") . suffix
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


" au! BufNewFile *.h call <SID>insert_gates()
au! BufNewFile *.h call HeaderguardAdd()<CR>

set cinoptions+=(0

" clang_complete options
let g:clang_complete_copen = 1
let g:clang_close_preview  = 1
let g:clang_complete_auto  = 1
let g:clang_hl_errors      = 0


map <C-I> :pyf /usr/share/vim/addons/syntax/clang-format-3.6.py<cr>
imap <C-I> <c-o>:pyf /usr/share/vim/addons/syntax/clang-format-3.6.py<cr>

nmap <silent> <Leader>of :FSHere<cr>

set fo+=ro

