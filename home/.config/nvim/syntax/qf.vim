if exists('b:current_syntax')
    finish
endif

syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^\:]*/ contained nextgroup=qfSeparatorMid
syn match qfSeparatorMid /\:/ contained nextgroup=qfColNr
syn match qfColNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfErrorPy /\%x00\w\{-1,}\(Error\)\@=.*$/
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained
syn match qfTraceback /^Traceback/ nextgroup=qfTraceBackNext
syn match qfTracebackNext /.*$/ contained
syn match qfNormal /^\(\(│ *\d*\: *\d*\|Traceback\)\@!.\)*$/

highlight! default link qfFileName Directory
highlight! default link qfSeparatorLeft Delimiter
highlight! default link qfSeparatorRight Delimiter
highlight! default link qfSeparatorMid Delimiter
highlight! default link qfLineNr DiagnosticWarn
highlight! default link qfColNr Number
highlight! default link qfTraceback DiagnosticSignError
highlight! default link qfTracebackNext DiagnosticWarn
highlight! default link qfError DiagnosticSignError
highlight! default link qfErrorPy DiagnosticSignError
highlight! default link qfWarning DiagnosticWarn
highlight! default link qfInfo DiagnosticWarn
highlight! default link qfNote DiagnosticWarn
highlight! default link qfNormal Normal

let b:current_syntax = 'qf'
