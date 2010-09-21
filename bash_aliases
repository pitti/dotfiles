#!/bin/bash
alias svim="sudo gvim"

alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"' 

alias ls='ls --color'

alias ll='ls -hla'
alias la='ls -A'
alias l='ls -lh'

# only load irssi if it does not run in a screen yet
alias irssi='if pgrep -U `id -u` irssi; then screen -x irssi;else screen -S irssi irssi;fi'
alias spac="sudo pacman"

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

alias -- +='pushd .'
alias -- -='popd'

alias sjunrar='unrar x -Pserienjunkies.org'
alias 'g'='gvim --remote-silent'
