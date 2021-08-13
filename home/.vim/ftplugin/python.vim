set expandtab

" Set the folding method
set foldmethod=indent
set foldnestmax=4

" Implements different textwidth for comments and normal code
if !exists('g:pep8_text_width')
    " Code textwidth.
    let g:pep8_text_width = 92
endif

if !exists('g:pep8_comment_text_width')
    " Comment textwidth.
    let g:pep8_comment_text_width = 72
endif

" augroup pep8textwidth
"     autocmd!
"     autocmd! CursorMoved,CursorMovedI <buffer> :exe 'setlocal textwidth='.s:GetCurrentTextWidth()
" augroup END

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
" autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf --style="{based_on_style: pep8; SPLIT_BEFORE_NAMED_ASSIGNS: False, DEDENT_CLOSING_BRACKETS: False}"<CR>
