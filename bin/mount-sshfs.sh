#!/bin/bash

cond_mount() {
	if [ -z "$(mount | grep -q '$1')" ]; then
		sshfs -o idmap=user $1 $2
		echo "mounted $1 to $2"
	else
		echo "$1 already mounted!" >&2
	fi
}


cond_mount wilkinson:work $HOME/work
cond_mount wilkinson:/opt/site /opt/site
