# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="ys"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git compleat)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt MULTIBYTE

gitdir=$HOME/.rcfiles

if [ -d $gitdir/zshrc.conf.d ]; then
  for conf in $gitdir/zshrc.conf.d/* ; do
    source $conf
  done
fi

eval `dircolors $gitdir/dircolors.256dark`

unset gitdir


# Rehash on every completed command.
zstyle ":completion:*:commands" rehash 1
zstyle ':completion:*' special-dirs true

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


bindkey "\eOd" backward-word
bindkey "\eOc" forward-word

# Use "Alt-." for last word of the previous command
bindkey "\e." insert-last-word

# Customize to your needs...
#
setopt HIST_IGNORE_SPACE
