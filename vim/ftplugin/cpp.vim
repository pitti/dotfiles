
augroup cpp_fswitch_rules
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp,tpp,cc,c'
  au BufEnter *.c,*.cpp let b:fswitchdst = 'h,hpp'
  au BufEnter *.tpp let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.tpp let b:fswitchdst = 'h,hpp'
augroup END

