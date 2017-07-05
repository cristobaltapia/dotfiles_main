#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Set language for the console
export LANG="en_US.UTF-8"

export EDITORCMD="gvim"
export EDITOR="vim"

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
