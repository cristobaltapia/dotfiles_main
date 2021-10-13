#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="[\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]]:\[\e[36m\]\W\[\e[m\]\[\e[31m\]\`parse_git_branch\`\[\e[m\]$ "

# Set language for the console
export LANG="en_US.UTF-8"

export EDITORCMD="nvim-qt"
export EDITOR="nvim"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Virtual Environment
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# F*EX
export PATH="$HOME/.fex/bin:$PATH"
source $HOME/.local/bin/fexdox-completion.bash

eval $(dircolors ~/.dircolors)

export PATH="$HOME/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="$HOME/.poetry/bin:$PATH"

# Enable tab-completion for directories after variables
shopt -s direxpand

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# br
source /home/tapia/.config/broot/launcher/bash/br

# Generic colourizer
[[ -s "/etc/profile.d/grc.bashrc" ]] && source /etc/profile.d/grc.bashrc

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Force xterm-color on ssh sessions
alias ssh='TERM=xterm-256color ssh'

if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

# set PROMPT_COMMAND
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

eval "$(starship init bash)"

alias obs="QT_QPA_PLATFORM=xcb obs"

# Tmux with lf
# alias mc='tmux new-session \; send-keys lf C-m \; split -h \; send-keys lf C-m'


# Install packages using yay (change to pacman/AUR helper of your choice)
function yayinstall() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}

################################################
# FZF config
export FZF_DEFAULT_OPTS='--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#d08770,marker:#d08770,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1'
export FZF_ALT_C_OPTS='--height=40% --min-height=20'
export FZF_CTRL_T_OPTS='--height=40% --min-height=20'

# Default commands
export FZF_DEFAULT_COMMAND="fd"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

source ${HOME}/.local/share/fzf/fzf-git.bash
