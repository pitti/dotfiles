# bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILE=$HOME/.bash_history
export HISTSIZE=100000

# The directory of the rcfiles from the repository (in order to locate the
# aliases file and import it)
gitdir=$HOME/.dotfiles

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [ "$TERM" != "dumb" ] && [ -x /bin/dircolors ]; then
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

HOST=`uname`

# load system wide bash completion if installed
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Load Alias definitions.
if [ -f $gitdir/bash_aliases ]; then
	. $gitdir/bash_aliases
fi

# Private alias file for confidential stuff
[ -f $gitdir/bash_aliases_private ] && source $gitdir/bash_aliases_private

if [ -d ~/.local/bin ]; then
	export PATH=$HOME/bin:$HOME/.local/bin:$PATH
fi

if [ -d ~/bin ]; then
	export PATH=$PATH:~/bin
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
export _JAVA_OPTIONS="-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

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

alias vim="vim --noplugin"

export EDITOR="vim"
