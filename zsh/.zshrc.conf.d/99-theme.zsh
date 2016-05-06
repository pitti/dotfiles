setopt prompt_subst

function p_envs {
  local envs
  [[ -n $SSH_CLIENT ]]  && envs+="R"
  [[ -n $envs ]] && echo " %F{green}[%f$envs%F{green}]%f"
}

function p_vcs {
  vcs_info
  echo $vcs_info_msg_0_
}

function p_arrow {
  if [[ $KEYMAP = "vicmd" ]]; then
    echo "%F{magenta}»%f"
  else
    echo "%F{cyan}»%f"
  fi
}

function p_colored_path {
  local slash="%F{cyan}/%f"
  echo "${${PWD/#$HOME/~}//\//$slash}"
}

PROMPT='
%F{blue}λ%f $(p_colored_path)$(p_envs)$(p_vcs)
$(p_arrow) '


# vim: set ft=zsh :
