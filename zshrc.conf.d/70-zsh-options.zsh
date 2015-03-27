
unsetopt correct_all
unsetopt MULTIBYTE

setopt extendedglob

setopt HIST_IGNORE_SPACE

# key timeout for things like VI mode
export KEYTIMEOUT=1

# german umlauts should not be counted as word boundaries for things
# like Ctrl-W
export WORDCHARS="äöüß"

autoload -U select-word-style
select-word-style normal

