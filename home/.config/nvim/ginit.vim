if exists('g:GtkGuiLoaded')
    " call rpcnotify(1, 'Gui', 'Font', 'Noto Mono for Powerline 10')
    call rpcnotify(1, 'Gui', 'Font', 'Fira Code 11')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
else
    " Guifont Noto\ Mono\ for\ Powerline:h10
    Guifont Fira\ Code:h11
endif
