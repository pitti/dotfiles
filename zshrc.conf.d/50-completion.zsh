

# Rehash on every completed command.
zstyle ":completion:*:commands" rehash 1

# complete .. to ../
zstyle ':completion:*' special-dirs true


# Complete for files after equal sign (FOO=/..)
setopt magic_equal_subst
