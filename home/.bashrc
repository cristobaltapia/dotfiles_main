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

export VDPAU_DRIVER=va_gl
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

[1;36m        clone[0m printf[1;31m        clone[0m printf
