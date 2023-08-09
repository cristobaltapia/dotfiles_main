" Typst compiler for neovim
if exists("current_compiler")
  finish
endif

let current_compiler = 'abaqus'
let s:keepcpo= &cpo
set cpo&vim

CompilerSet errorformat=
            \%-PAbaqus\ JOB\ %f,
            \%-GIntel(R)%.%#,
            \%-GCopyright%.%#,
            \%A%f(%l):\ %trror\ \#%n:\ %m,
            \%A%f(%l):\ %tarning\ \#%n:\ %m,
            \%-C%.%#,
            \%-Z%p^,
            \%f(%l):\ %temark\ \#%n:\ %m,
            \Abaqus\ %trror:\ %.%#:\ [Errno\ %n]\ %m,
            \ifort:\ command\ line\ %tarning\ \#%n:\ %m,
            \%-G%.%#,
"
" Wrap the text in the quickfix window
augroup quickfix_abaqus
        autocmd!
        autocmd BufReadPost quickfix setlocal wrap
augroup END

let &cpo = s:keepcpo
unlet s:keepcpo
