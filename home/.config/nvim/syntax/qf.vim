if exists("b:current_syntax")
    finish
endif

syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained
syn match qfTraceback /^Traceback/ nextgroup=qfTraceBackNext
syn match qfTracebackNext /.*$/ contained
syn match qfNormal /^\(\(│line\:\|Traceback\)\@!.\)*$/

hi def link qfFileName Directory
hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfLineNr LineNr
hi def link qfNormal Normal
hi def link qfTraceback CocErrorSign
hi def link qfError CocErrorSign
hi def link qfWarning CocWarningSign
hi def link qfInfo CocInfoSign
hi def link qfNote CocHintSign

let b:current_syntax = 'qf'
