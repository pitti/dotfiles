
eval $(gnome-keyring-daemon --replace --components=secrets,gpg,pkcs11,ssh)
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GPG_AGENT_INFO
