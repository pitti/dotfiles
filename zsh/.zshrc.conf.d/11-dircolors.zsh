# eval $(dircolors $scriptdir/dircolors.256dark)

autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [[ $OSTYPE =~ freebsd* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=tty'
fi

