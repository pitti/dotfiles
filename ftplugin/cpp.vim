" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1


let b:fswitchlocs = '.'



" insert header gates
function! s:insert_gates()
	let suffix = "_INCLUDED_"
	let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g") . suffix
	execute "normal! i#ifndef " . gname
	execute "normal! o#define " . gname
	execute "normal! Go#endif // " . gname
	normal! ko
endfunction


au! BufNewFile *.h call <SID>insert_gates()


" clang_complete options
let g:clang_complete_copen = 1
let g:clang_close_preview  = 1
let g:clang_complete_auto  = 1
let g:clang_hl_errors      = 0
let g:clang_library_path = "/opt/site/devtools/linux-3-x86_64-debian-6/clang/clang+llvm-3.2/lib"

nmap <silent> <Leader>of :FSHere<cr>
nnoremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


