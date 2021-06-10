#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autocompletion for pubs
eval "$(register-python-argcomplete pubs)"

#export PATH="${PATH}:/opt/anaconda/bin"
export MPA="$HOME/Documents/MPA"
export NVIM_GTK_NO_HEADERBAR=1

source /home/tapia/.config/broot/launcher/bash/br

export PATH="$HOME/.poetry/bin:$PATH"
