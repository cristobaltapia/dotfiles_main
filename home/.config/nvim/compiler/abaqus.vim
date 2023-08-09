" Typst compiler for neovim
if exists("current_compiler")
  finish
endif

let current_compiler = 'abaqus'
let s:keepcpo= &cpo
set cpo&vim

CompilerSet errorformat=
            \%A%f(%l):\ %trror\ \#%n:\ %m,
            \%A%f(%l):\ %tarning\ \#%n:\ %m,
            \%-Z%p^,
            \%-G%.%#

let &cpo = s:keepcpo
unlet s:keepcpo

let b:dispatch = 'abq2022 make library=%'

