
# knuth is currently still on lenny and lacks some libraries.
if [[ $HOST != "knuth" ]]; then
  path=(/opt/site/devtools/x86_64-linux-gnu/vim74/bin "$path[@]")
fi

