
##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################

# display a unicaode character by its code
# taken from:
# http://n2.nabble.com/How-to-enter-unicode-in-F9-tp1477113p1477241.html
unicode() { /usr/bin/printf \\u$1; }

bash_prompt_command() {
    local last_command=$?

    # How many characters of the $PWD should be kept
    local pwdmaxlen=20
    # Indicate that there has been dir truncation
    local trunc_symbol=$(unicode 2026) #".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
    echo -ne "\033]0;${NEW_PWD} - ${USER}@${HOSTNAME}\007"
}

bash_prompt() {
    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    local UC=$W                 # user's color
    [ $UID -eq "0" ] && UC=$R   # root's color

    # handle git branches
    local GITPS1='$(__maybe_git_ps1 ":%s" )'

    # without colors: PS1="[\u@\h:\${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
    PS1="${EMK}[${UC}\u${EMK}@${UC}\h${EMK}:${C}\${NEW_PWD}${Y}${GITPS1}${EMK}]${UC}\\$ ${NONE}"
    PS2="${W}-${EMK}-${NONE} "
}

__maybe_git_ps1()
{
  local BRANCH="$(__git_ps1 '%s' )"
  case "$BRANCH" in
    master)
     : # silent
    ;;
    '')
     : # not a git repo? -> silent
    ;;
    *)
    if [ -n "$1" ]; then
      printf "$1" "$BRANCH"
    else
      printf " (%s)" "$BRANCH"
    fi
   ;;
  esac
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
