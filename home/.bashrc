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

alias ls='ls --color=auto'
export PS1="[\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]]:\[\e[36m\]\W\[\e[m\]\[\e[31m\]\`parse_git_branch\`\[\e[m\]$ "

# Set language for the console
export LANG="en_US.UTF-8"

export EDITORCMD="nvim-qt"
export EDITOR="nvim"

#export VIM="/usr/share/nvim"
#export VIMRUNTIME="/usr/share/nvim/runtime"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

#export VDPAU_DRIVER=va_gl
# Powertop
#echo 'on' > '/sys/bus/usb/devices/usb1/power/control';
#echo 'on' > '/sys/bus/usb/devices/usb2/power/control';
#echo 'on' > '/sys/bus/usb/devices/usb3/power/control';
#echo 'on' > '/sys/bus/pci/devices/0000:02:00.0/power/control';

# Virtual Environment
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

#PYTHONPATH="${PYTHONPATH}:/home/tapia/salomei/appli_V7_7_1/bin/salome"
#export PYTHONPATH

#. /home/tapia/torch/install/bin/torch-activate

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

export PATH="/opt/anaconda/bin:$PATH"

PROG=gopass

_cli_bash_autocomplete() {
     local cur opts base
     COMPREPLY=()
     cur="${COMP_WORDS[COMP_CWORD]}"
     opts=$( ${COMP_WORDS[@]:0:$COMP_CWORD} --generate-bash-completion )
     COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
     return 0
 }

complete -F _cli_bash_autocomplete $PROG


if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# F*EX
export PATH="$HOME/.fex/bin:$PATH"

eval $(dircolors ~/.dircolors)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
