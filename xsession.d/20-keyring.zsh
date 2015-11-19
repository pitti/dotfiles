
eval $(gnome-keyring-daemon --start --components=secrets,gpg,pkcs11,ssh)

export SSH_AUTH_SOCK
