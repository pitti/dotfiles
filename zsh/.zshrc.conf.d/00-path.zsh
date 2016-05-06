
# unique entries in path array (which is tied to $PATH)
typeset -U path

path=(~/.local/bin /usr/lib/llvm-3.7/bin $path)

typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path

ld_library_path=(~/.local/lib /usr/local/lib)

export LD_LIBRARY_PATH
