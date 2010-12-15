# bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILE=$HOME/.bash_history
export HISTSIZE=100000

# permanent hist
export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \ "$(history 1)" >> ~/.bash_permanent_history'

# The directory of the rcfiles from the repository (in order to locate the
# aliases file and import it)
gitdir=$HOME/.rcfiles

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

COLOR1="\[\e[33;1m\]" # yellow
COLOR2="\[\e[32;1m\]" # green
COLOR3="\[\e[37m\]" # grey
COLOR4="\[\e[1;31m\]" # red
ENDCOLOR="\[\e[0m\]"
DEFCOLOR=$ENDCOLOR
# PS1="\[$COLOR1\!\[$COLOR2[\[\033[1;34m\]\A\[\033[0m\]\
# \[\033[1;32m\] \u@\h \[\033[0m\]\
# \[\033[1;33m\]\W\[\033[0m\]]\$ "

# handle git branches in prompt
GITPS1='$(__maybe_git_ps1 "(%s) " )'

UC=$COLOR3
[ $UID -eq "0" ] && UC=$COLOR4 # red for root

PS1="${UC}\u${COLOR3}:\H $COLOR1\w$DEFCOLOR $COLOR2${GITPS1}$ENDCOLOR\$ "

case "$TERM" in
	xterm*|rxvt*)
	PROMPT_COMMAND='echo -ne "\033]0;${PWD} - ${USER}@${HOSTNAME}\007"'
	;;
	*)
	;;
esac

export LSCOLORS="dxhxxxxxCxxxxxxb"

HOST=`uname`

# load system wide bash completion if installed
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Load Alias definitions.
if [ -f $gitdir/bash_aliases ]; then
	. $gitdir/bash_aliases
fi

if [ -d ~/.local/bin ]; then
	export PATH=$HOME/.local/bin:$PATH
fi

if [ -d /usr/local/bin ]; then
	export PATH=$PATH:/usr/local/bin
fi

# add non default installation paths to PATH
for dir in {kde,gtkwave,ghdl,geda,java}; do
	if [ -d /opt/$dir/bin ]; then
		export PATH=$PATH:/opt/$dir/bin
	fi
done

# Fix Java applications for awesome wm
export AWT_TOOLKIT=MToolkit

export JAVA_HOME=/opt/java

# Load bash functions
if [ -f $gitdir/bash_functions ]; then
	. $gitdir/bash_functions
fi

# Load bash functions
if [ -f $HOME/.bash_env ]; then
	. $HOME/.bash_env
fi

# Tell me that it's sudo asking for the pw
SUDO_PROMPT="[sudo] password:"


export EDITOR="vim"

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
