" syntax off
" filetype plugin indent on
" syntax on
syntax spell toplevel
"

let g:tex_flavor = 'latex'

let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'nvim',
            \ 'background' : 1,
            \ 'build_dir' : 'aux-folder',
            \ 'callback' : 0,
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

let g:vimtex_grammar_vlty = {}
" let g:vimtex_grammar_vlty.lt_directory = '/usr/share/languagetool'
let g:vimtex_grammar_vlty.lt_command = 'languagetool'
let g:vimtex_grammar_vlty.server = 'my'
let g:vimtex_grammar_vlty.show_suggestions = 1
let g:vimtex_grammar_vlty.shell_options =
        \   ' --multi-language'
        \ . ' --packages "*"'
        \ . ' --define ~/vlty/defs.tex'
        \ . ' --replace ~/vlty/repls.txt'
        \ . ' --equation-punctuation display'
        \ . ' --single-letters "i.\,A.\|z.\,B.\|\|"'
        \ . " --lt-options '~--language en-US'"


let g:vimtex_grammar_textidote = {
            \ 'jar': '/opt/textidote/textidote.jar',
            \ 'args': '',
            \}

" map <F9> :w <bar> compiler vlty <bar> make <bar> :cw <cr><esc>

let g:vimtex_compiler_latexmk_engines = {'_' : '-lualatex'}

" Set variables
let g:vimtex_complete_enabled = 0
let g:vimtex_complete_close_braces = 0
let g:vimtex_complete_ignore_case = 1
let g:vimtex_complete_smart_case = 1
let g:vimtex_fold_enabled = 1
" setlocal conceallevel=1
let g:tex_conceal='abdmg'
setlocal concealcursor=

let g:vimtex_indent_enabled = 1
let g:vimtex_indent_on_ampersands = 0
let g:vimtex_indent_bib_enabled = 1
" let g:vimtex_parser_bib_backend = "bibparse"

let g:vimtex_imaps_leader = '#'
let g:vimtex_quickfix_method = 'latexlog'
let g:matchup_override_vimtex = 1
let g:vimtex_compiler_progname = $HOME.'/.virtualenvs/py3neovim/bin/nvr'

" Function to autofocus zathura after each \lv call
function! VimtexHookZathura() abort
  let xwin_id = get(b:vimtex.viewer, 'xwin_id')
  if xwin_id > 0
    silent call system('xdotool windowactivate ' . xwin_id . ' --sync')
    silent call system('xdotool windowraise ' . xwin_id)
  endif
endfunction

let g:vimtex_view_method = 'zathura'
" let g:vimtex_view_zathura_hook_view = 'VimtexHookZathura'
let g:vimtex_view_forward_search_on_start = 1

let g:vimtex_echo_verbose_input = 0
" let g:vimtex_quickfix_enabled = 0

let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_quickfix_open_on_warning = 0

" let g:matchup_matchparen_deferred = 1
"
" Add custom mapping through vimtex#imap#add_map
call vimtex#imaps#add_map({
            \ 'lhs' : '%',
            \ 'rhs' : '\percent',
            \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
            \})

call vimtex#imaps#add_map({
            \ 'lhs' : '_',
            \ 'rhs' : '\textsubscript',
            \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
            \})

call vimtex#imaps#add_map({
            \ 'lhs' : '^',
            \ 'rhs' : '\textsuperscript',
            \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
            \})

" Delimiter modifiers
let g:vimtex_delim_list = {'mods' : {}}
let g:vimtex_delim_list.mods.name = [
      \ ['\left', '\right'],
      \ ['\mleft', '\mright'],
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \ ['\big', '\big'],
      \ ['\Big', '\Big'],
      \ ['\bigg', '\bigg'],
      \ ['\Bigg', '\Bigg'],
      \]
let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\mleft', '\mright'],
  \]


" Mappings
nmap <localleader>ll <Plug>(vimtex-compile-ss)
vmap <localleader>ll <Plug>(vimtex-compile-selected)
nmap <localleader>lv <Plug>(vimtex-view)
nmap <localleader>lo <Plug>(vimtex-compile-output)
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

function! GitPDFLatexDiff(old, new)
    echo a:old
    execute '!mkdir -p latex-diff'
    execute '!git latexdiff --latexmk --latexopt "-pdf" --tmpdirprefix "latex-diff" --output "latex-diff/diff-output" --no-view --main ' .'%:t '. a:old .' '. a:new
endfunction

command! -nargs=* -complete=file GitLatexDiff :call GitLatexDiff(<f-args>)
command! -nargs=* -complete=file GitPDFLatexDiff :call GitPDFLatexDiff(<f-args>)

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

