#!/bin/bash

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
			*)           echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# 'td' creates or switches to the directory '~/temp/<date>', 'td -1' creates or
# switches to the <date> of yesterday, and so on. This also works for +1 etc.

# Change the default directory scheme by modifying the next line
export TD="$HOME/temp/`date +'%Y-%m-%d'`"

td(){
	td=$TD
	if [ ! -z "$1" ]; then
		td="$HOME/temp/`date -d "$1 days" +'%Y-%m-%d'`";
	fi
	mkdir -p $td; cd $td
	unset td
}
