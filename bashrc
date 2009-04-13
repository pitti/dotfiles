# bashrc - klmann

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

export HISTFILE="~/.bash_history"
export HISTSIZE=1000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

COLOR1="\[\e[33;1m\]" # brown 
COLOR2="\[\e[32;1m\]" # green
COLOR3="\[\e[34m\]"
ENDCOLOR="\[\e[0m\]"
DEFCOLOR=$ENDCOLOR
# PS1="\[$COLOR1\!\[$COLOR2[\[\033[1;34m\]\A\[\033[0m\]\
# \[\033[1;32m\] \u@\h \[\033[0m\]\
# \[\033[1;33m\]\W\[\033[0m\]]\$ "

PS1="${COLOR1}\u:\H $COLOR2\w$DEFCOLOR \$ $ENDCOLOR"

case "$TERM" in
	xterm*|rxvt*)
	PROMPT_COMMAND='echo -ne "\033]0;${PWD} - ${USER}@${HOSTNAME}\007"'
	;;
	*)
	;;
esac

export LSCOLORS="dxhxxxxxCxxxxxxb"

HOST=`uname`


if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


if [ -f ~/.rcfiles/bash_aliases ]; then
    . ~/.rcfiles/bash_aliases
fi

if [ -d ~/.local/bin ]; then
  export PATH=$HOME/.local/bin:$PATH
fi

# Fix Java applications for awesome wm
export AWT_TOOLKIT=MToolkit
