
# zshrc split into multiple files

# Figure out the directory of this zshrc by following the ~/.zshrc
# symlink
zshscript=$(readlink -f ~/.zshrc)
scriptdir="${zshscript:A:h}"

if [ -d $scriptdir/zshrc.conf.d ]; then
  for conf in $scriptdir/zshrc.conf.d/* ; do
    source $conf
  done
fi

unset scriptdir
