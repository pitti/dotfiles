:call IMAP('II', '\lstinline{<++>}<++>', 'tex')
:call IMAP('IC', '\code{<++>}<++>', 'tex')

" vim-latexsuite options
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf        = 'evince'
let g:tex_indent_items        = 1

" Use german quote style in TeX sources
let g:Tex_SmartQuoteOpen  = '"`'
let g:Tex_SmartQuoteClose = "\"'"
