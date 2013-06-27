
alias svim="sudo gvim"

alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"' 

alias ll='ls -hla'
alias la='ls -A'
alias l='ls -lh'

# only load irssi if it does not run in a screen yet
# alias irssi='if pgrep -U `id -u` irssi; then screen -x irssi;else screen -S irssi irssi;fi'
alias spac="sudo pacmatic"

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

alias -- +='pushd .'
alias -- -='popd'

alias sjunrar='unrar x -Pserienjunkies.org'
alias sj2unrar='unrar x -Pserienjunkies.dl.am'
alias 'g'='gvim --remote-tab-silent'

alias man='man -P less'

alias texerr='pdflatex -interaction nonstopmode *.tex | grep -i error'

alias sysc-env='export SYSTEMC=$HOME/.local'

alias myps='ps -fjH -u `whoami`'


alias gka='gitk --all'
