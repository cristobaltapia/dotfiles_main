if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Noto Mono for Powerline 10')
else
    Guifont Noto\ Mono\ for\ Powerline:h10
endif
