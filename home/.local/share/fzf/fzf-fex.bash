#!/usr/bin/env bash

# GIT heart Fex
# -------------

fzf-down() {
  fzf --height 60% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

_fl() {
  fexdox -i tapia -l |
  fzf-down -m --ansi --nth 2..,..
}


