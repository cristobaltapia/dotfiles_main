#!/usr/bin/env bash

_fexdox_completions()
{
  if [ "${#COMP_WORDS[@]}" > "3" ]; then
    # Consider account ID if given
    if [ "${COMP_WORDS[1]}" = "-i" ]; then
      fexuser=${COMP_WORDS[2]}
      remotes=$(fexdox -i ${fexuser} -l | awk '{print $5}')
      COMPREPLY=($(compgen -W "${remotes}" "${COMP_WORDS[-1]}"))
    else
      remotes=$(fexdox -l | awk '{print $5}')
      COMPREPLY=($(compgen -W "${remotes}" "${COMP_WORDS[-1]}"))
    fi
  else
    remotes=$(fexdox -l | awk '{print $5}')
    COMPREPLY=($(compgen -W "${remotes}" "${COMP_WORDS[-1]}"))
  fi

}

complete -F _fexdox_completions fexdox
