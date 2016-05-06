#!/bin/zsh

# load computer-specific stuff
custom_script="$HOME/.xsession.$(uname -n).zsh"
[ -f "$custom_script" ] && source $custom_script

# load snippets
confdir=$HOME/.xsession.d

if [ -d $confdir ]; then
  for conf in $confdir/* ; do
    source $conf
  done
fi

unset scriptdir

exec ${session_binary:-lxsession}
