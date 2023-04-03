
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}”
zstyle ':completion:*' group-name ''
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' substitute 1
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/tapia/.zshrc'

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Surroundings
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Completions:
# - Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
# - Pyenv
fpath=($HOME/.config/zsh/comp $fpath)

path=($HOME/bin $path)

autoload -Uz compinit
compinit

# FEX
compdef _gnu_generic fexsend fexget fexpush \
    fexpull fexstore fexpack fexzip fexsync \
    autofex xx xxx sexsend sexget sexxx

autoload -Uz promptinit
promptinit

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
bindkey -v

bindkey "^?" backward-delete-char
bindkey "^w" backward-delete-word

# Change cursor
# source "$HOME/.config/zsh/plugins/cursor_mode"

# Starship
eval "$(starship init zsh)"

# Set language for the console
export LANG="en_US.UTF-8"
export EDITORCMD="nvim-qt"
export EDITOR="nvim"

#----------------------------------------------------------------------
# Virtual Environment
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

#----------------------------------------------------------------------
# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || path=($PYENV_ROOT/bin $path)
eval "$(pyenv init -)"

#----------------------------------------------------------------------
# F*EX
path=($HOME/.fex/bin $path)

# Force xterm-color on ssh sessions
alias ssh='TERM=xterm-256color ssh'

if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

#----------------------------------------------------------------------
# Install packages using yay (change to pacman/AUR helper of your choice)
function yayinstall() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}

#----------------------------------------------------------------------
# FZF
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# - Options
export FZF_DEFAULT_OPTS='--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#d08770,marker:#d08770,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1'
export FZF_ALT_C_OPTS='--height=40% --min-height=20'
export FZF_CTRL_T_OPTS='--height=40% --min-height=20'
# Default commands
export FZF_DEFAULT_COMMAND="fd"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

#----------------------------------------------------------------------
# Colors
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

export JULIA_NUM_THREADS=4

export MPA="$HOME/Documents/MPA"
export NVIM_GTK_NO_HEADERBAR=1

export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

