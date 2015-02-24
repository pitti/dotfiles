# key bindings

autoload zkbd
zkbdfile=~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
[[ ! -f $zkbdfile ]] && zkbdfile=~/.zkbd/default
[[ -f $zkbdfile ]] && source $zkbdfile


[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char


bindkey "^R" history-incremental-pattern-search-backward

bindkey "\eOd" backward-word
bindkey "\eOc" forward-word

# Use "Alt-." for last word of the previous command
bindkey "\e." insert-last-word

