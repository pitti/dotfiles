
Bundle 'jcf/vim-latex'

:call IMAP('II', '\lstinline{<++>}<++>', 'tex')
:call IMAP('IC', '\code{<++>}<++>', 'tex')

:call IMAP('EFR', "\\begin{frame}\<CR>\\frametitle{<+title+>}\<CR><++>\<CR>\\end{frame}<++>", 'tex')

:call IMAP('SVG', "\\begin{figure}[<+pos+>]\<CR>\\centering\<CR>\\includesvg[latex=<+latex+>,width=\\textwidth]{<+file+>}\<CR>\\caption{<+caption+>}\<CR>\\label{fig:<+label+>}\<CR>\\end{figure}<++>", 'tex')

" vim-latexsuite options
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf        = 'evince'
let g:tex_indent_items        = 1

" No syntax error checking on tex files
let g:tex_no_error = 1
let g:tex_no_math = 1



" Use german quote style in TeX sources
let g:Tex_SmartQuoteOpen  = '"`'
let g:Tex_SmartQuoteClose = "\"'"


" surround plugin latex addition: 
" Allow \begin{} and \end{} to change with the special keyword l
" (lower-case L)
let g:surround_108 = "\\begin{\1environment: \1}\r\\end{\1\r}.*\r\1}"


" Fix latexsuide ALT key mappings for urxvt by re-binding the escape
" sequences
execute "set <A-i>=\ei"
execute "set <A-c>=\ec"
