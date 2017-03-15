" 
" Vim configuration file
" Author: Cristóbal Tapia Camú
"
" Load vim-plug
if has('win32')
    " this does not work, but I leave it here just to remember what I need to do
    if empty(glob("~/vimfiles/autoload/plug.vim"))
        execute 'md ~\vimfiles\autoload'
        execute "$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
        execute '(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\autoload\plug.vim"))'
    endif
else
    if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    endif

endif

"----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Neocomplete
Plug 'Shougo/neocomplete.vim'
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'
" vim-Grammarous
Plug 'rhysd/vim-grammarous'
"SuperTab
Plug 'ervandew/supertab'
" Track the engine.
Plug 'SirVer/ultisnips'
" Virtualenv support
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
" Pydoc
Plug 'fs111/pydoc.vim', { 'for': 'python' }
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Vim Easy Align
Plug 'junegunn/vim-easy-align'
" fugitive.vim: a Git wrappe
Plug 'tpope/vim-fugitive'
"APDL Syntax
Plug 'cristobaltapia/apdl.vim'
" Better file browser
Plug 'scrooloose/nerdtree'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Emmet
Plug 'mattn/emmet-vim'
" Tab list panel
Plug 'kien/tabman.vim'
" Vim-Airline
Plug 'bling/vim-airline'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Fix white spaces at end of lines
Plug 'bronson/vim-trailing-whitespace'
" Matlab
Plug 'MatlabFilesEdition'
" Conda Environment
Plug 'cjrh/vim-conda'
" Latex
Plug 'gerw/vim-latex-suite', {'for': 'tex' }
Plut 'vim-latex/vim-latex', {'for', 'tex' }
" Rename. Rename a buffer within Vim and on disk
Plug 'Rename'
" Search results counter
Plug 'IndexedSearch'
" XML/HTML tags navigation
Plug 'matchit.zip'
" Numbers (relative numbers)
Plug 'myusuf3/numbers.vim'
" Ctrl P
Plug 'kien/ctrlp.vim', { 'for': 'python' }
" Python mode
Plug 'python-mode/python-mode', { 'for': 'python' }
" Vim indent guides (colors!)
Plug 'nathanaelkane/vim-indent-guides'
" Solirized colorscheme
Plug 'altercation/vim-colors-solarized'
" Base16 colorscheme
Plug 'chriskempson/base16-vim'
" ALE
Plug 'w0rp/ale', { 'for': 'python' }
" Asyncrun
Plug 'skywind3000/asyncrun.vim'
" Space-vim-dark colorscheme
Plug 'liuchengxu/space-vim-dark'
" Vim-Jupyter integration
"Plug 'ivanov/vim-ipython'
" Plugins that will only work under linux
if has("unix")
    " Codi, an interactive scratchpad for vim
    Plugin 'metakirby5/codi.vim', { 'for': 'python' }
    " YouCompleteMe
    Plug 'Valloric/YouCompleteMe'
endif

call plug#end()

" Latex options
let g:tex_flavor='latex'

"----------------------------------------------------------------------
" mapping to Open Vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" ...and to Source Vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
"----------------------------------------------------------------------
" In windows, solve the problem of the repositioning of the gui window
if has('win32')
    set guioptions=egrt
else
    "More space to write! :)
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
endif
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" tabs and spaces handling
"----------------------------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set virtualedit=block

"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Ignore some file extensions
set wildignore=*.swp,*.bak,*.pyc,*.class,*.aux,*.toc
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" tablength exceptions
"----------------------------------------------------------------------
augroup file_type
    autocmd!
    "autocmd FileType python colorscheme wombat-mod
    autocmd FileType python colorscheme space-vim-dark
    autocmd FileType python AirlineRefresh
    autocmd FileType python setlocal shiftwidth=4
                \ tabstop=4
                \ softtabstop=4
                \ expandtab
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    autocmd FileType tex AirlineRefresh
    autocmd FileType tex setlocal shiftwidth=2
                \ tabstop=2
                \ softtabstop=2
                \ expandtab
augroup END

"----------------------------------------------------------------------
" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch
" map to stop highlighting of last search
nnoremap <leader>pp :nohlsearch<cr>
" line numbers
set nu

" toggle Tagbar display
noremap <F4> :TagbarToggle<CR>
" autofocus on Tagbar open
let g:tagbar_autofocus = 1

"----------------------------------------------------------------------
" Custom remaps
"----------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Buffer navigation
"----------------------------------------------------------------------
" Preference when using buffers. See `:h hidden` for more details
set hidden
" Move to the next buffer
nmap tn :bnext<CR>
" Move to the previous buffer
nmap tp :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

"----------------------------------------------------------------------
" automatically close autocompletion window
augroup autocompl_window
    autocmd!
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

"----------------------------------------------------------------------
" show pending tasks list
noremap <F2> :TaskList<CR>

"----------------------------------------------------------------------
" colors and settings of autocompletion
highlight Pmenu ctermbg=4 guibg=LightGray
" highlight PmenuSel ctermbg=8 guibg=DarkBlue guifg=Red
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>
" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" colors for gvim
if has('gui_running')
    colorscheme space-vim-dark
    "colorscheme molokai
endif
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" diverse options
"----------------------------------------------------------------------
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3
"Files are read as soon as they are changed
set autoread
" don't use swapfile for the buffers
set noswapfile
" don't show error messages
set noerrorbells
" set visual bell instead of beeping
set visualbell
" don't use backup files
set nobackup
set nowritebackup
" set the character encoding to utf-8
set encoding=utf-8
" set the default folding method
set foldmethod=marker
" Highlight the current line
set cursorline
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Powerline configurations
"----------------------------------------------------------------------
let g:Powerline_symbols = 'fancy'

let g:airline_powerline_fonts=1
if has('win32')
    set guifont=Source\ Code\ Pro\ for\ Powerline:h10
else
    set guifont=Source\ Code\ Pro\ for\ Powerline
endif
"----------------------------------------------------------------------

"----------------------------------------------------------------------
"" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

syntax on
filetype on
let python_highlight_all=1

"----------------------------------------------------------------------
" Solve Backspace problem in Windows
if has('win32')
    set backspace=indent,eol,start
endif
"----------------------------------------------------------------------

" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Visual selection automatically copies to the clipboard
if has('win32')
    set go+=a
else
    nnoremap y "+y
    vnoremap y "+y
    snoremap y "+y
    nnoremap <S-Insert> "+p
endif

"----------------------------------------------------------------------
" Ultisnips
"----------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" define own sippets directorie
let g:UltiSnipsSnippetDirectories=["UltiSnips", "MySnippets"]


"----------------------------------------------------------------------
" Configuration for vim-easy-align
"----------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" Redefinition of easy-align rules
" A rule for the symbol '!' was added, since that is the symbol to
" comment in the APDL-language (Ansys)
let g:easy_align_delimiters = {
            \ '>': { 'pattern': '>>\|=>\|>' },
            \ '/': { 'pattern': '//\+\|/\*\|\*/', 'ignore_groups': ['String'] },
            \ '!': { 'pattern': '!\+', 'ignore_groups': ['String'], 'delimiter_align': 'l' },
            \ '#': { 'pattern': '#\+', 'ignore_groups': ['String'], 'delimiter_align': 'l' },
            \ ']': {
            \     'pattern':       '[[\]]',
            \     'left_margin':   0,
            \     'right_margin':  0,
            \     'stick_to_left': 0
            \   },
            \ ')': {
            \     'pattern':       '[()]',
            \     'left_margin':   0,
            \     'right_margin':  0,
            \     'stick_to_left': 0
            \   },
            \ 'd': {
            \     'pattern': ' \(\S\+\s*[;=]\)\@=',
            \     'left_margin': 0,
            \     'right_margin': 0
            \   }
            \ }
"----------------------------------------------------------------------

"----------------------------------------------------------------------
if has('win32')
    let $TMP="c:/Temp"
    set directory=.,$TMP,$TEMP
endif
"----------------------------------------------------------------------

"----------------------------------------------------------------------
"Map <Esc> to Shift-Space. Its more confortable
imap <S-Space> <Esc>
vmap <S-Space> <Esc>
smap <S-Space> <Esc>
"----------------------------------------------------------------------

" Change buffer without saving
set hidden

"----------------------------------------------------------------------
" Folding remaping
nnoremap <space> za
vnoremap <space> zf
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" linebreaks with indentation
set breakindent showbreak=..
set linebreak
"----------------------------------------------------------------------

"----------------------------------------------------------------------
"
"----------------------------------------------------------------------
" Ale configurations
"----------------------------------------------------------------------
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
            \   'python': ['flake8','pylint'],
            \}

" Run linters on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 1
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" NERD Commenter configurations
"----------------------------------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Redefine Diff function
if has('win32')
    set diffexpr=MyDiff()
    function! MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                if empty(&shellxquote)
                    let l:shxq_sav = ''
                    set shellxquote&
                endif
                let cmd = '"' . 'C:\Program Files (x86)\GnuWin32\bin\diff"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = 'C:\Program Files (x86)\GnuWin32\bin\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
        if exists('l:shxq_sav')
            let &shellxquote=l:shxq_sav
        endif
    endfunction
endif

" Pydoc
let g:pydoc_cmd = 'python -m pydoc'

" pydoc to switch to an already open tab with pydoc page
let g:pydoc_use_drop=1
" lines to show doc
"let g:pydoc_window_lines=20
let g:pydoc_window_lines=0.5
" Highlight search term
let g:pydoc_highlight=1
"
" Latex-Suite Template folder
" Edit commands for the navifation in help documents
nnoremap <C-9> :<C-]>

" Suppress message of vim-conda
let g:conda_startup_msg_suppress = 1
let g:UltisnipsUsePythonVersion = 3

" Setting for grammar check (Grammarous)
let g:grammarous#disabled_rules = {
            \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES', 'COMMA_PARENTHESIS_WHITESPACE'],
            \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
            \ }
" Use vim spellang
let g:grammarous#use_vim_spelllang = 1


"----------------------------------------------------------------------
" Quick run
"----------------------------------------------------------------------
nnoremap <F5> :call <SID>compile_and_run()<CR>
" close quickfix window
nnoremap <Leader>cq :ccl<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(25, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
        exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
        exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
        exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
        exec "AsyncRun python %:p"
    endif
endfunction

cd %:p:h
"----------------------------------------------------------------------
"
" vp doesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
