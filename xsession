#!/bin/bash

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_PAPER="de_DE.UTF-8"

export OOO_FORCE_DESKTOP=gnome
export G_FILENAME_ENCODING="UTF-8"

export _JAVA_AWT_WM_NONREPARENTING=1

export PATH=$HOME/.local/bin:$PATH

export TEXMFCNF=$HOME/.texmf-config/web2c:

# load user's ~/.Xmodmap, if it exists
[ ! -f ~/.Xmodmap ] || xmodmap ~/.Xmodmap

urxvtd -q -o -f

# ~/.local/bin/vmup.sh

echo "Starting Session..."

gnome-session --session=myawesome

# ( ~/.local/bin/vmrdp-wojewodski ) &

# cleanup gnome-keyring-daemon, if still running
if kill -0 "$GNOME_KEYRING_PID" ; then
  kill -HUP "$GNOME_KEYRING_PID"
fi

URXVTD_PID=`pidof urxvtd`
if [ -n "${URXVTD_PID}" ] ; then
  kill -KILL "${URXVTD_PID}"
fi

# # if [ 1 -ge `w | cut -d" " -f1 | grep "${USER}" | wc -l` ]
# # then
# # 	for mdir in "${!mount_dirs[@]}"; do
# # 		fusermount -u ${mount_dirs["$mdir"]}
# # 	done
# # fi

