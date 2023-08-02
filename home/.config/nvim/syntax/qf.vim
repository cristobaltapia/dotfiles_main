if exists('b:current_syntax')
    finish
endif

syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^\:]*/ contained nextgroup=qfSeparatorMid
syn match qfSeparatorMid /\:/ contained nextgroup=qfColNr
syn match qfColNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote,qfModule
syn match qfError / E .*$/ contained
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained
syn match qfModule / \S*/ contained nextgroup=qfErrorPy
syn match qfErrorPy /\w\{-1,}\(Error\)/
syn match qfTraceback /^Traceback/ nextgroup=qfTraceBackNext
syn match qfTracebackNext /.*$/ contained
syn match qfNormal /^\(\(│ *\d*\: *\d*\|Traceback\)\@!.\)*$/

highlight! default link qfFileName Directory
highlight! default link qfSeparatorLeft Delimiter
highlight! default link qfSeparatorRight Delimiter
highlight! default link qfSeparatorMid Delimiter
highlight! default link qfLineNr DiagnosticWarn
highlight! default link qfColNr Number
highlight! default link qfTraceback Debug
highlight! default link qfTracebackNext Normal
highlight! default link qfError Debug
highlight! default link qfErrorPy Debug
highlight! default link qfWarning SpecialChar
highlight! default link qfModule SpecialChar
highlight! default link qfInfo Character
highlight! default link qfNote Label
highlight! default link qfNormal Normal
highlight MyQuickFixLine cterm=none
highlight! default link QuickFixLine MyQuickFixLine

let b:current_syntax = 'qf'
