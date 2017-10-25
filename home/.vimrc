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
endif

if has('vim')
    if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    endif
endif

"----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
"
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Own snippets
Plug 'cristobaltapia/MySnippets'
" Rainbow parentheses
Plug 'luochen1990/rainbow', { 'for': 'python' }
" vim-Grammarous
Plug 'rhysd/vim-grammarous'
"SuperTab
Plug 'ervandew/supertab'
" Virtualenv support
" Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'tpict/vim-virtualenv', { 'for': 'python', 'commit': 'c9a52e5' }
" Pydoc
Plug 'fs111/pydoc.vim', { 'for': 'python' }
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
Plug 'vim-scripts/MatlabFilesEdition'
" Conda Environment
Plug 'cjrh/vim-conda'
" Latex
Plug 'vim-latex/vim-latex', {'for': 'tex' }
" Rename. Rename a buffer within Vim and on disk
Plug 'vim-scripts/Rename'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
Plug 'vim-scripts/matchit.zip'
" " Numbers (relative numbers)
Plug 'myusuf3/numbers.vim'
" Ctrl P
Plug 'kien/ctrlp.vim', { 'for': 'python' }
" Python mode
Plug 'python-mode/python-mode', { 'for': 'python' }
" Vim indent guides (colors!)
Plug 'nathanaelkane/vim-indent-guides'
" Solirized colorscheme
Plug 'altercation/vim-colors-solarized'
" Oceanic-next colorscheme
Plug 'mhartington/oceanic-next'
" Base16 colorscheme
Plug 'chriskempson/base16-vim'
" ALE
Plug 'w0rp/ale', { 'for': ['python', 'tex', 'fortran'] }
" Asyncrun
Plug 'skywind3000/asyncrun.vim'
" Dispatch
Plug 'tpope/vim-dispatch'
" Space-vim-dark colorscheme
Plug 'liuchengxu/space-vim-dark'
" vim-jason: a better json
Plug 'elzr/vim-json', {'for': 'json'}
" Jedi-vim
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Plugins that will only work under linux
if has("unix")
    " Codi, an interactive scratchpad for vim
    Plug 'metakirby5/codi.vim', { 'for': 'python' }
    " Game code-break
    Plug 'johngrib/vim-game-code-break'
endif

if  has("vim")
    " Neocomplete + snippets
    Plug 'Shougo/neocomplete.vim'
elseif has("nvim")
    " Deoplete (completion)
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Jedi for deoplete
    Plug 'zchee/deoplete-jedi'
    " Ipython terminal
    Plug 'hkupty/iron.nvim', {'for': 'python'}
endif

call plug#end()

" Latex options
let g:tex_flavor='latex'

" Change direcotry to folder of opened file
cd %:p:h

"----------------------------------------------------------------------
" Diverse options
"----------------------------------------------------------------------
set scrolloff=3     " When scrolling, keep cursor 3 lines away from screen border
set autoread        " Files are read as soon as they are changed
set noswapfile      " Don't use swapfile for the buffers
set noerrorbells    " Don't show error messages
set visualbell      " Set visual bell instead of beeping
set nobackup        " Don't use backup files
set nowritebackup
set encoding=utf-8  " Set the character encoding to utf-8
set foldmethod=marker   " Set the default folding method
set cursorline      " Highlight the current line
set breakindent showbreak=..    " Linebreaks with indentation
set linebreak
set hidden          " Change buffer without saving
set expandtab       " Use spaces to replace tabs
set tabstop=4       " Number of spaces that a <Tab> in the file counts for
set softtabstop=4   " Number of spaces that a <Tab> counts for on editing operations
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set virtualedit=block   " Allow virtual editing in Visual block mode
set wildignore=*.swp,*.bak,*.pyc,*.class,*.aux,*.toc    " Ignore some file extensions
set laststatus=2    " Always show status bar
set incsearch       " Incremental search
set hlsearch        " Highlighted search results
set nu              " Line numbers
set hidden          " Preference when using buffers

if (has("termguicolors"))
    set termguicolors
endif

" For conceal markers.
if has('conceal')
  set conceallevel=0 concealcursor=niv
endif

if has('win32')
    set go+=a                       " Visual selection automatically copies to the clipboard
    set backspace=indent,eol,start  " Solve Backspace problem in Windows
    set guioptions=egrt             " Solve problem of repositioning of the GUI
    let $TMP="c:/Temp"              " Change temp directory
    set directory=.,$TMP,$TEMP      " ...
else
    " Visual selection automatically copies to the clipboard
    nnoremap y "+y
    vnoremap y "+y
    snoremap y "+y
    nnoremap <S-Insert> "+p
    " More space to write! :)
    set guioptions-=m  " Remove menu bar
    set guioptions-=T  " Remove toolbar
endif

" Colors for GVim
if has('gui_running')
    colorscheme space-vim-dark
elseif has('nvim')
    colorscheme space-vim-dark
endif

"----------------------------------------------------------------------
" Mappings
"----------------------------------------------------------------------
" Map to stop highlighting of last search
nnoremap <leader>pp :nohlsearch<cr>

" Folding remaping
nnoremap <space> za
vnoremap <space> zf

" Map <Esc> to Shift-Space. Its more confortable
inoremap <S-Space> <Esc>
vnoremap <S-Space> <Esc>
snoremap <S-Space> <Esc>

" Mapping to Open Vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" ...and to Source Vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Movements
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Move to the next buffer
nmap tn :bnext<CR>
" Move to the previous buffer
nmap tp :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
" Show pending tasks list
noremap <F2> :TaskList<CR>
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Tablength exceptions
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
    autocmd FileType fortran setlocal shiftwidth=3
                \ tabstop=3
                \ softtabstop=3
                \ expandtab
augroup END

"----------------------------------------------------------------------
" Toggle Tagbar display
noremap <F4> :TagbarToggle<CR>
" Autofocus on Tagbar open
let g:tagbar_autofocus = 1

"----------------------------------------------------------------------
" Automatically close autocompletion window
augroup autocompl_window
    autocmd!
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

"----------------------------------------------------------------------
" Rainbow parentheses
"----------------------------------------------------------------------
let g:rainbow_active = 1
let g:rainbow_conf = {
            \'guifgs': ['darkorange', 'seagreen', 'royalblue', 'firebrick'],
            \'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \'operators': '_,_',
            \'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \'separately': {
            \    '*': {},
            \    'tex': {
            \        'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \    },
            \    'lisp': {
            \        'guifgs': ['royalblue', 'darkorange', 'seagreen', 'firebrick', 'darkorchid'],
            \    },
            \    'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>
" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Powerline configurations
"----------------------------------------------------------------------
"let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
if has('win32')
    set guifont=Source\ Code\ Pro\ for\ Powerline:h10
elseif has('vim')
    set guifont=Noto\ Mono\ for\ Powerline
endif

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Enable virtualenv integration
let g:airline#extensions#virtualenv#enabled = 1
" Cooperation with Asyncrun
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

"----------------------------------------------------------------------

"----------------------------------------------------------------------

if has('vim')
    " Neocomplete configuration
    "let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
endif

"
" Ultisnip configuration
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsSnippetDirectories=[
            \'~/.vim/plugged/MySnippets/'
            \'~/.vim/plugged/vim-snippets/snippets',
            \'Ultisnips',
            \]

"----------------------------------------------------------------------
" Deoplete
"----------------------------------------------------------------------
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" PYTHON CONFIGURATION
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

syntax on
filetype on
let python_highlight_all=1

" Pydoc
"----------------------------------------------------------------------
let g:pydoc_cmd = 'python -m pydoc'

" pydoc to switch to an already open tab with pydoc page
let g:pydoc_use_drop=1
" lines to show doc
"let g:pydoc_window_lines=20
let g:pydoc_window_lines=0.5
" Highlight search term
let g:pydoc_highlight=1
"
"-------------------------------------------------------------
" Python-mode
"-------------------------------------------------------------
" Deactivate everything except the syntax
let g:pymode_rope = 0
"" Documentation
let g:pymode_doc = 0
" Linting
let g:pymode_lint = 0
" Support virtualenv
let g:pymode_virtualenv = 0
" breakpoints plugin
let g:pymode_breakpoint = 0
" folding
let g:pymode_folding = 0
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
"
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
"-------------------------------------------------------------
" Jedi-vim
"-------------------------------------------------------------
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0

"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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
" Ale configurations
"----------------------------------------------------------------------
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
            \   'python': ['flake8','pylint'],
            \   'tex': ['chktex', 'proselint'],
            \   'fortran': ['gcc'],
            \}

" Run linters on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" linters run on opening a file
let g:ale_lint_on_enter = 1

let g:ale_fixers = {
            \   'python': ['yapf'],
            \}

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

" Latex-Suite Template folder
" Edit commands for the navifation in help documents
nnoremap <C-9> <C-]>

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

"----------------------------------------------------------------------
" vp ddoesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
"
" Colors of the line numbers
highlight LineNr guifg=#aa9911

" Fix problem with detected file changes
function! ProcessFileChangedShell()
    if v:fcs_reason == 'mode' || v:fcs_reason == 'time'
        let v:fcs_choice = ''
    else
        let v:fcs_choice = 'ask'
    endif
endfunction

autocmd FileChangedShell <buffer> call ProcessFileChangedShell()
