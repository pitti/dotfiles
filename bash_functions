#!/bin/zsh

# handy function for extracting various archive types

# TODO: implement correct behaviour of extra argument(s) given to 'extract'
# (i.e. extract -Ppassword foo.rar should result in the command 'unrar x
# -Ppassword foo.rar'
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1        ;;
			*.tar.gz)    tar xvzf $1     ;;
			*.bz2)       bunzip2 $1       ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1     ;;
			*.tar)       tar xvf $1        ;;
			*.tbz2)      tar xvjf $1      ;;
			*.tgz)       tar xvzf $1       ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1    ;;
			*.rar)       unrar x $1    ;;
			*.xz)        xz -d $1    ;;
			*)           echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# 'td' creates or switches to the directory '~/temp/<date>', 'td -1' creates or
# switches to the <date> of yesterday, and so on. This also works for +1 etc.

# Change the default directory scheme by modifying the next line
DEFAULT_PTEMPDIR=${DEFAULT_PTEMPDIR:-"$HOME/temp"}

export DEFAULT_PTEMPDIR

# Remember date to avoid pointing to different directories when the session
# lasts through midnight ;)
export TEMP_DATE_TODAY="$(date +'%Y-%m-%d')"

td(){
	td=$DEFAULT_PTEMPDIR/$TEMP_DATE_TODAY
	if [ ! -z "$1" ]; then
		td="$DEFAULT_PTEMPDIR/$(date -d "$TEMP_DATE_TODAY $1 days" +'%Y-%m-%d')";
	fi
	mkdir -p $td; cd $td
	unset td
}

# grep recursively from $PWD using 'grr'
grr() {
	if [ -z "$*" ]; then
		echo "Usage: gr <expr> to search for <expr> in files recursively"
	else
		grep -C 2 --color -RTn $* .
	fi
}

latexmks () {
	latexmk -e '$latex=q/pdflatex %O -shell-escape %S/' "$@"
}

fixenv() {
  for key in DISPLAY SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}

gpg-open() {
  set -x
  filename="$1"
  orig_ending="${filename[(ws:.:)2]}"
  tmpfile="$(mktemp -u --suffix .${orig_ending})"
  gpg -o ${tmpfile} -d ${filename}
  xdg-open ${tmpfile}
  rm -i ${tmpfile}
}
