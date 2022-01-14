if exists("b:current_syntax")
    finish
endif

syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^\:]*/ contained nextgroup=qfSeparatorMid
syn match qfSeparatorMid /\:/ contained nextgroup=qfColNr
syn match qfColNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfErrorPy /\w\{-1,}\(Error\)\@=.*$/
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained
syn match qfTraceback /^Traceback/ nextgroup=qfTraceBackNext
syn match qfTracebackNext /.*$/ contained
syn match qfNormal /^\(\(│ *\d*\: *\d*\|Traceback\)\@!.\)*$/

hi def link qfFileName Directory
hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfSeparatorMid Delimiter
hi def link qfLineNr DiagnosticWarn
hi def link qfColNr Number
hi def link qfTraceback CocErrorSign
hi def link qfError CocErrorSign
hi def link qfErrorPy CocErrorSign
hi def link qfWarning CocWarningSign
hi def link qfInfo CocInfoSign
hi def link qfNote CocHintSign
hi def link qfNormal Normal

let b:current_syntax = 'qf'
