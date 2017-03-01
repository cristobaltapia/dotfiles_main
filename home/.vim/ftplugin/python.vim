" Execute file being edited with <Shift> + e:
" set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" nmap <F5> :!python "%:p" <CR>
"
" cd %:p:h
"set guioptions-=l
"set guioptions-=r
"set guioptions-=R
"set guioptions-=L

set expandtab
"set textwidth=79
"set tabstop=8
"set softtabstop=4
"set shiftwidth=4
"set autoindent

" Set the folding method
set foldmethod=indent
set foldnestmax=4

" Implements different textwidth for comments and normal code
if !exists('g:pep8_text_width')
    " Code textwidth.
    let g:pep8_text_width = 79
endif

if !exists('g:pep8_comment_text_width')
    " Comment textwidth.
    let g:pep8_comment_text_width = 72
endif

augroup pep8textwidth
    autocmd!
    autocmd! CursorMoved,CursorMovedI <buffer> :exe 'setlocal textwidth='.s:GetCurrentTextWidth()
augroup END

" Return appropriate textwidth for cursor position (leverages syntax engine).
function! s:GetCurrentTextWidth()
    let curr_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    let prev_syntax = synIDattr(synIDtrans(synID(line("."), col(".")-1, 0)), "name")
    if curr_syntax =~ 'Comment\|Constant' || prev_syntax =~ 'Comment\|Constant'
        return g:pep8_comment_text_width
    endif
    return g:pep8_text_width
endfunction

" Sort imports
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf --style="{based_on_style: pep8; SPLIT_BEFORE_NAMED_ASSIGNS: False, DEDENT_CLOSING_BRACKETS: False}"<CR>
" autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf --style=H:/.config/yapf/format<CR>
"
