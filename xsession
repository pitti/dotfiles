#!/bin/zsh

# where are we
xsessionscript=$(readlink -f ~/.xsession)
scriptdir="${xsessionscript:A:h}"

# load computer-specific stuff
custom_script="$scriptdir/xsession.$(uname -n).zsh"
[ -f "$custom_script" ] && source $custom_script

# load snippets
confdir=$scriptdir/xsession.d

if [ -d $confdir ]; then
  for conf in $confdir/* ; do
    source $conf
  done
fi

unset scriptdir

exec ${session_binary:-lxsession}
