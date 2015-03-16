:call IMAP('II', '\lstinline{<++>}<++>', 'tex')
:call IMAP('IC', '\code{<++>}<++>', 'tex')

:call IMAP('EFR', "\\begin{frame}\<CR>\\frametitle{<+title+>}\<CR><++>\<CR>\\end{frame}<++>", 'tex')

:call IMAP('SVG', "\\begin{figure}[<+pos+>]\<CR>\\centering\<CR>\\includesvg[latex=<+latex+>,width=\\textwidth]{<+file+>}\<CR>\\caption{<+caption+>}\<CR>\\label{fig:<+label+>}\<CR>\\end{figure}<++>", 'tex')

" vim-latexsuite options
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf        = 'evince'
let g:tex_indent_items        = 1

" Use german quote style in TeX sources
let g:Tex_SmartQuoteOpen  = '"`'
let g:Tex_SmartQuoteClose = "\"'"


" Fix latexsuide ALT key mappings for urxvt by re-binding the escape
" sequences
execute "set <A-i>=\ei"
execute "set <A-c>=\ec"
