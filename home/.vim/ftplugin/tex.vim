syntax enable
syntax spell toplevel
"
filetype plugin on

let g:tex_flavor = 'latex'

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

let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'nvim',
            \ 'background' : 1,
            \ 'build_dir' : 'aux-folder',
            \ 'callback' : 1,
            \ 'continuous' : 0,
            \ 'executable' : 'latexmk',
            \ 'options' : [
            \   '-verbose',
            \   '-shell-escape',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}

let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-lualatex',
            \ 'pdflatex'         : '-pdf',
            \ 'dvipdfex'         : '-pdfdvi',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}

" Set variables
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_close_braces = 1
let g:vimtex_fold_enabled = 1

let g:vimtex_indent_enabled = 0
let g:vimtex_indent_bib_enabled = 1
let g:vimtex_indent_delims = 1
let g:vimtex_indent_ignored_envs = 1
let g:vimtex_indent_lists = 1
let g:vimtex_indent_on_ampersands = 1
let g:vimtex_imaps_leader = '#'
let g:vimtex_quickfix_method = 'latexlog'

" Configure deoplete to use vimtex
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" Mappings
nmap <localleader>ll <Plug>(vimtex-compile-ss)
imap <localleader>ll <Plug>(vimtex-compile-ss)
vmap <localleader>ll <Plug>(vimtex-compile-selected)

nmap <localleader>lv <Plug>(vimtex-view)
imap <localleader>lv <Plug>(vimtex-view)

nmap <localleader>lo <Plug>(vimtex-compile-output)
imap <localleader>lo <Plug>(vimtex-compile-output)

nmap <localleader>rf :VimtexRefreshFolds<CR>

nmap <localleader>lt <Plug>(vimtex-toc-open)

"----------------------------------------------------------------------
"
map <F4> :w !detex \| wc -w<CR>

" Run a latexdiff
function! GitLatexDiff(old, new)
    echo a:old
    execute '!mkdir latex-diff'
    execute '!git latexdiff --biber --latexmk --latexopt "-pdf -pdflatex=lualatex" --tmpdirprefix "latex-diff" --output "latex-diff/diff-output" --no-view --main ' .'%:t '. a:old .' '. a:new
endfunction

command! -nargs=* -complete=file GitLatexDiff :call GitLatexDiff(<f-args>)

