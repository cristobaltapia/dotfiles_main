set runtimepath^=~/.vim,~/.vim/after
set packpath+=~/.vim

if empty(glob("~/.vim/autoload/plug.vim"))
    execute "!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

source ~/.vimrc

