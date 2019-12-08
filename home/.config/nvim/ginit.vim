if exists('g:GtkGuiLoaded')
    " call rpcnotify(1, 'Gui', 'Font', 'Noto Mono for Powerline 10')
    call rpcnotify(1, 'Gui', 'Font', 'FuraCode Nerd Font 11')
    " call rpcnotify(1, 'Gui', 'Font', 'Fura Code Regular Nerd Font Complete.otf 11')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
    call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
else
    " Guifont Noto\ Mono\ for\ Powerline:h10
    " Guifont Fira\ Code:h11
    Guifont Fura\ Code:h11
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
