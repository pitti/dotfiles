xbattbar="$(which xbattbar)"

[ -n "$xbattbar" ] && $xbattbar -s ~/.local/bin/batt-stat.sh &

