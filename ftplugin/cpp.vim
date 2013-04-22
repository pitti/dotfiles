let b:fswitchdst = 'h,hpp'
let b:fswitchlocs = '.'


autocmd! BufNewFile *.h   call <SID>insert_gates()
autocmd! BufNewFile *.hpp call <SID>insert_gates()

" insert header gates
function! s:insert_gates()
	let suffix = "_INCLUDED_"
	let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g") . suffix
	execute "normal! i#ifndef " . gname
	execute "normal! o#define " . gname
	execute "normal! Go#endif // " . gname
	normal! k
endfunction


" clang_complete options
let g:clang_complete_copen = 1
let g:clang_close_preview  = 1
let g:clang_complete_auto  = 1
let g:clang_hl_errors      = 0

nmap <silent> <Leader>of :FSHere<cr>
nnoremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


