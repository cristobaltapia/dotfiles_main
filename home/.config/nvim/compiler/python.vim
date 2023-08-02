" Python compiler for neovim
if exists("current_compiler")
  finish
endif

let current_compiler = "python"

let s:cpo_save = &cpo
set cpo&vim

" First we capture the line saying 'Traceback ...' and ignore it.
set errorformat=%-GTraceback%.%#
" Parse the start of a multi-line error:
" This line contains the source file, the line number of the error and the
" module/function where the error occurred. However, the module is not
" always present, therefore we have two similar lines.
set errorformat+=%E\ \ File\ \"%f\"\\\,\ line\ %l\\\,\ in\ %o%\\C
set errorformat+=%E\ \ File\ \"%f\"\\\,\ line\ %l%\\C
" A series of symbols '^' mark the position causing the error. This
" information can be used to recover an estimation of the column number
" causing the error. The line normally starts with four (4) spaces. The
" column is an estimation due to the indentation of the code.
set errorformat+=%C\ \ \ \ %p^
" The next line contains verbatim the code from the line causing the error.
" The line begins with four (4) spaces. We ignore this line with '%-C'.
set errorformat+=%-C\ \ \ \ %.%#
" Finally, we recover the actual message corresponding to the error. The
" prefix '%Z' indicates that this is the end of the multi-line error message.
set errorformat+=%+Z%.%#%trror:\ %.%#
" The next line considers the warning messages. This is also a multi-line
" error message, which starts with the information corresponding to the
" source file and line number. Also the type of warning is given, which is
" here captured in a general manner. We use the prefix '%>' to only consider
" errorformats defined from this point downwards.
set errorformat+=%W%>%f:%l:\ %.%#%tarning%m
" The second line of the warning message is similar as above, where the
" incumbent line is presented verbatim. We ignore this line and finish the
" multi-line error.
set errorformat+=%C\ \ %.%#
" Get any second line continuing the previous message.
set errorformat+=%+C%.%#
" We finish the multi-line warning if there is an empty line. (I think there
" is no guarantee that this works always, but is seems to work pretty good
" in general.)
set errorformat+=%-Z
" Ignore any other line.
set errorformat+=%+G

" Wrap the text in the quickfix window
augroup quickfix_python
        autocmd!
        autocmd BufReadPost quickfix setlocal wrap
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
