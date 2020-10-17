" set background=light
" colorscheme solarized8_high
" AirlineTheme solarized

" let g:gruvbox_contrast_light='hard'
" let g:gruvbox_invert_selection=1
" let g:gruvbox_improved_strings=1
" let g:gruvbox_underline=1

" set background=light
" colorscheme gruvbox
" AirlineTheme gruvbox

noremap <C-t> :FzfTagQuery

" function! VimwikiFindIncompleteTasks()
"   lvimgrep /\([0-9]\+\.\|-\|\*\) \[ \]/ %:p
"   lopen
" endfunction

" function! VimwikiFindAllIncompleteTasks()
"   VimwikiSearch /\([0-9]\+\.\|-\|\*\) \[ \]/
"   lopen
" endfunction

" nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
" nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

" set conceallevel=3
" set concealcursor=v
