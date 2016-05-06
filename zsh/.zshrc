#!/usr/bin/env zsh

scriptdir="$HOME/.zshrc.conf.d"

if [ -d $scriptdir ]; then
  for conf in $scriptdir/* ; do
    source $conf
  done
fi

unset scriptdir
