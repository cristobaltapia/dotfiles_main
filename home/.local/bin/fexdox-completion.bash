#!/usr/bin/env bash

_fexdox_completions()
{
  # Consider account ID if given
  options=""
  for IDX in ${!COMP_WORDS[@]}; do
    if [[ ${COMP_WORDS[$IDX]} = "-i" ]]; then
      # Get username
      options="-i ${COMP_WORDS[$(($IDX+1))]}"
    fi
  done
  case ${COMP_WORDS[-2]} in
    -s )
      COMPREPLY=($(compgen -o dirnames "${COMP_WORDS[-1]}"));;
    -r )
      remotes=$(fexdox ${options} -l | awk '{print $5}')
      COMPREPLY=($(compgen -W "${remotes}" "${COMP_WORDS[-1]}"));;
    -D )
      remotes=$(fexdox ${options} -l | awk '{print $5}')
      COMPREPLY=($(compgen -W "${remotes}" "${COMP_WORDS[-1]}"));;
    -l )
      remotes=$(fexdox ${options} -l | awk '{print $5}')
      COMPREPLY=($(compgen -W "${remotes}" "${COMP_WORDS[-1]}"));;
  esac
}

complete -F _fexdox_completions fexdox
