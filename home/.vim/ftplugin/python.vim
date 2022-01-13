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

set errorformat=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%C\ %m,%Z%[%^\ ]%\\@=%m
set errorformat+=%W%f:%l:\ %m,%Z%m
"----------------------------------------------------------------------
" Quickfix format
"----------------------------------------------------------------------
lua << EOF
function _G.qftf(info)
    local items
    local ret = {}
    if info.quickfix == 1 then
        items = vim.fn.getqflist({id = info.id, items = 0}).items
    else
        items = vim.fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    print(items)
    local limit = 31
    local fname_fmt1, fname_fmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local valid_fmt = '%s │line: %5d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = vim.fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fname_fmt1:format(fname)
                else
                    fname = fname_fmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = valid_fmt:format(fname, lnum, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end
EOF

set quickfixtextfunc={info\ ->\ v:lua._G.qftf(info)}
" vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

" Sort imports
" autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf --style="{based_on_style: pep8; SPLIT_BEFORE_NAMED_ASSIGNS: False, DEDENT_CLOSING_BRACKETS: False}"<CR>
