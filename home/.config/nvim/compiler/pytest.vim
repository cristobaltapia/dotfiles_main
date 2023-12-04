" Vim compiler file
" Compiler:	Testing using Pytest for Python
" Maintainer:	kahlil hodgson <kahlil.hodgson999@gmail.coml>
" Last Change: 2020-02-16

if exists("current_compiler")
  finish
endif

let current_compiler = "pytest"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" Disable Python warnings
if !exists('$PYTHONWARNINGS')
  let $PYTHONWARNINGS="ignore"
endif

let s:cpo_save = &cpo
set cpo&vim
set cpo-=C

CompilerSet makeprg=pytest\ --tb=short\ -vv\ $*
CompilerSet errorformat=
      \%EE\ \ \ \ \ File\ \"%f\"\\,\ line\ %l,
      \%CE\ \ \ %p^,
      \%ZE\ \ \ %[%^\ ]%\\@=%m,
      \%Afile\ %f\\,\ line\ %l,
      \%+ZE\ %mnot\ found,
      \%CE\ %.%#,
      \%-G_%\\+\ ERROR%.%#\ _%\\+,
      \%A_%\\+\ %o\ _%\\+,
      \%C%f:%l:\ in\ %o,
      \%ZE\ %\\{3}%m,
      \%EImportError%.%#\'%f\'\.,
      \%C%.%#,
      \%+G%[=]%\\+\ %*\\d\ passed%.%#,
      \%-G%[%^E]%.%#,
      \%-G

let &cpo = s:cpo_save
unlet s:cpo_save
