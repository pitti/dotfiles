
# unique entries in path array (which is tied to $PATH)
typeset -U path


path=(~/.local/bin "$path[@]")
