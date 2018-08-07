imap <buffer> <M-o> <Plug>Tex_InsertItemOnThisLine
let g:Tex_GotoError=0

set grepprg=grep\ -nH\ $*
let g:Imap_UsePlaceHolders = 1
imap <buffer> <M-o> <Plug>Tex_InsertItemOnThisLine

syntax enable
syntax spell toplevel
"
filetype plugin on

let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
"
" Disable some functionality of vim-latex-suite
let g:Tex_SectionMenus = 0
let g:Tex_SectionMaps = 0
let g:Tex_FontMenus = 0
let g:Tex_FontMaps = 1
let g:Tex_EnvironmentMenus = 0
let g:Tex_SmartKeyBS = 0
let g:Tex_SmartKeyDot = 0
let g:Tex_GotoError = 0
let g:Tex_Diacritics = 0
let g:Tex_UsePython = 1
" Set smart quote
let g:Tex_SmartKeyQuote = 1
let g:Tex_SmartQuoteOpen = "``"
let g:Tex_SmartQuoteClose = "''"

let g:Tex_Folding = 1
let g:Tex_AutoFolding = 1
" Define Custom template folder
let g:Tex_CustomTemplateDirectory = '~/Templates/latex'
let g:Imap_FreezeImap = 0
let g:Tex_FoldedEnvironments = 'verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage,frame'

"let g:Tex_BibtexFlavor = 'biber'
"
function! GetVisual() range
        let reg_save = getreg('"')
        let regtype_save = getregtype('"')
        let cb_save = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', reg_save, regtype_save)
        let &clipboard = cb_save
        return selection
endfunction

if has('win32')
    let g:Tex_ViewRule_pdf = 'SumatraPDF -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\""'
else
    function! SyncTex()
        let filename = bufname("%")
        let lineno = line(".")
        for syncfile in split(system('zgrep -l "' . filename . '" *.synctex.gz'), "\n")
            let pdffile = fnamemodify(Tex_GetMainFileName(), ":p:r")
            let pdffile2 = matchstr(pdffile, "[A-Za-z0-9_-]*$")
            "let pdffile = substitute(syncfile, ".synctex.gz$", ".pdf", "")
            exec 'silent !python /usr/lib/gedit/plugins/synctex/evince_dbus.py ' .
                        \ pdffile2 . '.pdf ' . lineno . ' ' . filename
        endfor
    endfunction
    nnoremap <buffer> <LocalLeader>lk :call SyncTex()<CR>
endif
"
" Compile rule for pdf
let g:Tex_CompileRule_pdf = 'latexmk -aux-directory=aux_files --output-directory=aux_files -pdf -pdflatex="lualatex --shell-escape --interaction=nonstopmode" $* && mv aux_files/%:r.pdf %:t:r.pdf'

" Run a latexdiff
function! GitLatexDiff(old, new)
    echo a:old
    execute '!mkdir latex-diff'
    execute '!git latexdiff --biber --latexmk --latexopt "-pdf -pdflatex=lualatex" --tmpdirprefix "latex-diff" --output "latex-diff/diff-output" --no-view --main ' .'%:t '. a:old .' '. a:new
endfunction

command! -nargs=* -complete=file GitLatexDiff :call GitLatexDiff(<f-args>)

" Latex + siunitx
call IMAP('ESI','\SI{<++>}{<++>}<++>','tex')
call IMAP('ESR','\SIrange{<++>}{<++>}{<++>}<++>','tex')
call IMAP('FEM','FEM','tex')

"----------------------------------------------------------------------
"
map <F4> :w !detex \| wc -w<CR>
