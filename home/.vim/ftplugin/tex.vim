imap <buffer> <M-o> <Plug>Tex_InsertItemOnThisLine
let g:Tex_GotoError=0

"set tabstop=2
"set softtabstop=2
"set shiftwidth=2

set grepprg=grep\ -nH\ $*
let g:Imap_UsePlaceHolders = 1
imap <buffer> <M-o> <Plug>Tex_InsertItemOnThisLine

syntax enable
syntax spell toplevel
"
filetype plugin on
"set shellslash  " conflict with vundle
"set grepprg=grep\ -nH\ $*
"filetype indent on
"let g:Tex_Leader=','  " I use this
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_BibtexFlavor = 'biber'
"let g:Tex_MultipleCompileFormats='pdf, aux, bib'
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
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=-1 -src-specials -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'latexmk -pdf -pdflatex="pdflatex -shell-escape -src-specials -interaction=nonstopmode" $*'
let g:Tex_CustomTemplateFolder='/home/tapia/Templates/latex'

" Latex + siunitx
call IMAP('ESI','\SI{<++>}{<++>}<++>','tex')
call IMAP('ESR','\SIrange{<++>}{<++>}{<++>}<++>','tex')

"----------------------------------------------------------------------
"Map <Esc> to Shift-Space. Its more confortable
inoremap <S-Space> <Esc>
vnoremap <S-Space> <Esc>
snoremap <S-Space> <Esc>
"----------------------------------------------------------------------
