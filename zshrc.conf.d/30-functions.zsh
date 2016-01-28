#!/bin/zsh

timestamp() {
  case $1 in 
    -f|--full) date +%Y%m%d%H%M%S ;;
    -h|--help) cat <<EOF

Print out a timestamp of the current date. Useful for prefixing dates to
files.

Options:
  -f, --full Print date and time
EOF
;;
    *) date +%Y%m%d ;;
esac
}

# handy function for extracting various archive types
extract () {
  hash dtrx 2>/dev/null && { dtrx -v $@ ; return }
  # fall back to old behaviour
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1                                   ;;
      *.tar.gz)    tar xvzf $1                                   ;;
      *.bz2)       bunzip2 $1                                    ;;
      *.rar)       unrar x $1                                    ;;
      *.gz)        gunzip $1                                     ;;
      *.tar)       tar xvf $1                                    ;;
      *.tbz2)      tar xvjf $1                                   ;;
      *.tgz)       tar xvzf $1                                   ;;
      *.zip)       unzip $1                                      ;;
      *.Z)         uncompress $1                                 ;;
      *.7z)        7z x $1                                       ;;
      *.rar)       unrar x $1                                    ;;
      *.xz)        xz -d $1                                      ;;
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
  local td=$DEFAULT_PTEMPDIR/$TEMP_DATE_TODAY
  if [[ ! -z "$1" ]]; then
    td="$DEFAULT_PTEMPDIR/$(date -d "$TEMP_DATE_TODAY $1 days" +'%Y-%m-%d')";
  fi
  mkdir -p $td && cd $td
}

# grep recursively from $PWD using 'grr'
grr() {
  hash ag 2>/dev/null && { ag $* ; return }
  if [[ -z "$*" ]]; then
    echo "Usage: gr <expr> to search for <expr> in files recursively"
  else
    grep -C 2 --color -RTn $* .
  fi
}

latexmks () {
  latexmk -shell-escape -pdf $@
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


# tm <session> starts or reuses a tmux session
tm() {
  tmux attach -t "$1" || tmux new-session -s "$1"
}
