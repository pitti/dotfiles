#!/bin/bash

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_PAPER="de_DE.UTF-8"

export OOO_FORCE_DESKTOP=GNOME
export G_FILENAME_ENCODING="UTF-8"

export PATH=$HOME/.local/bin:$PATH

# load user's ~/.Xmodmap, if it exists
[ ! -f ~/.Xmodmap ] || xmodmap ~/.Xmodmap

# Trick java-based applications to correctly redraw when using a
# non-reparenting window manager such as awesome-wm
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1

# Needed for synapse to show the correct .desktop entries.
export DESKTOP_SESSION=LXDE

# Turn off beep
xset b off

compton -b

redshift-gtk -l 53.14:8.21 &

wallpaper="$(xdg-user-dir PICTURES)/current"
awsetbg $wallpaper &

xbattbar="$(which xbattbar)"

[ -n "$xbattbar" ] && $xbattbar -s ~/.local/bin/batt-stat.sh &


CHROMIUM_FLAGS="--force-device-scale-factor=1"
export CHROMIUM_FLAGS
eval $(gnome-keyring-daemon --replace --components=secrets,gpg,pkcs11,ssh)
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GPG_AGENT_INFO

exec lxsession
