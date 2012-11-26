
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect

    " Ignore filetypes for *.tpp files
    autocmd! BufNewFile,BufRead *.tpp  setfiletype cpp

    autocmd! BufNewFile,BufRead *.asciidoc  setfiletype asciidoc


augroup END
