" Typst compiler for neovim
if exists("current_compiler")
  finish
endif

let current_compiler = "typst"

let s:cpo_save = &cpo
set cpo&vim

set errorformat=%Eerror:\ %m
set errorformat+=%Wwarning:\ %m
set errorformat+=%Ihelp:\ %m
set errorformat+=%C\ \ ┌─\ /%f:%l:%c
set errorformat+=%C\ \ \ ┌─\ /%f:%l:%c
set errorformat+=%C\ \ \ =\ %m
set errorformat+=%C%s
set errorformat+=%Z

let &cpo = s:cpo_save
unlet s:cpo_save
