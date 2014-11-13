#!/bin/bash

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_PAPER="de_DE.UTF-8"

export OOO_FORCE_DESKTOP=xfce
export G_FILENAME_ENCODING="UTF-8"


export PATH=$HOME/.local/bin:$PATH

export TEXMFCNF=$HOME/.texmf-config/web2c:

# load user's ~/.Xmodmap, if it exists
[ ! -f ~/.Xmodmap ] || xmodmap ~/.Xmodmap

# Trick java-based applications to correctly redraw when using a
# non-reparenting window manager such as awesome-wm
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1

# Needed for synapse to show the correct .desktop entries.
export DESKTOP_SESSION=XFCE

# Turn off beep
xset b off

compton -b

redshift-gtk -l 53.14:8.21 &

xbattbar="$(which xbattbar)"

[ -x $xbattbar ] && $xbattbar -s ~/.local/bin/batt-stat.sh

echo "Starting session"

exec xfce4-session
