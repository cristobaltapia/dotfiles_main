" Vim configuration file
set nocompatible              " be iMproved, required
filetype off                  " required

"----------------------------------------------------------------------
" no vi-compatible
" Setting up Vundle - the vim plugin bundler
if has('win32')
    let iCanHazVundle=1
    "let vundle_readme=expand('H:/vimfiles/bundle/vundle/README.md')
    let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle..."
        echo ""
        "silent !mkdir H:/vimfiles/bundle
        silent !mkdir ~/.vim/bundle
        "silent !git clone https://github.com/gmarik/Vundle.vim H:/vimfiles/bundle/Vundle.vim
        silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
        let iCanHazVundle=0
    endif
    set rtp+=$HOME/.vim/bundle/Vundle.vim
    call vundle#begin()
else
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle..."
        echo ""
        silent !mkdir -p $HOME/.vim/bundle
        silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
        let iCanHazVundle=0
    endif
    " set the runtime path to include Vundle and initialize
    set rtp+=$HOME/.vim/bundle/Vundle.vim
    call vundle#begin()
endif
"
"----------------------------------------------------------------------
"
" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'
" Neocomplete
Plugin 'Shougo/neocomplete.vim'
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
" vim-Grammarous
Plugin 'rhysd/vim-grammarous'
"SuperTab
Plugin 'ervandew/supertab'
"AutoComplPop
"Plugin 'vim-scripts/AutoComplPop'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Pydoc
Plugin 'fs111/pydoc.vim'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Vim Easy Align
Plugin 'junegunn/vim-easy-align'
" fugitive.vim: a Git wrappe
Plugin 'tpope/vim-fugitive'
"APDL Syntax
"Plugin 'vim-scripts/apdl.vim'
Plugin 'cristobaltapia/apdl.vim'
" Better file browser
Plugin 'scrooloose/nerdtree'
" Unite
Plugin 'Shougo/unite.vim'
" Code commenter
Plugin 'scrooloose/nerdcommenter'
" Emmet
Plugin 'mattn/emmet-vim'
" Tab list panel
Plugin 'kien/tabman.vim'
" Vim-Airline
Plugin 'bling/vim-airline'
" Jedi-Vim
Plugin 'davidhalter/jedi-vim'
" Gvim colorscheme
Plugin 'Wombat'
" Pending tasks list
Plugin 'fisadev/FixedTaskList.vim'
" Surround
Plugin 'tpope/vim-surround'
" Autoclose
Plugin 'Townk/vim-autoclose'
" Indent text object
Plugin 'michaeljsmith/vim-indent-object'
" Fix white spaces at end of lines
Plugin 'bronson/vim-trailing-whitespace'
" Matlab
Plugin 'MatlabFilesEdition'
" Conda Environment
Plugin 'cjrh/vim-conda'
" Latex
"Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'
Plugin 'gerw/vim-latex-suite'
"Plugin 'lervag/vimtex'
"Plugin 'lervag/vim-latex'
" Rename. Rename a buffer within Vim and on disk
Plugin 'Rename'
" Syntax checking hacks for vim
"Plugin 'scrooloose/syntastic'
" Search results counter
Plugin 'IndexedSearch'
" XML/HTML tags navigation
Plugin 'matchit.zip'
" Numbers (relative numbers)
Plugin 'myusuf3/numbers.vim'
" Ctrl P
Plugin 'kien/ctrlp.vim'
" YouCompleteMe
"Plugin 'Valloric/YouCompleteMe'
" Python mode
Plugin 'python-mode/python-mode'
" Vim indent guides (colors!)
Plugin 'nathanaelkane/vim-indent-guides'
" Pretty-Vim-Python syntax highlight
" Plugin 'sentientmachine/Pretty-Vim-Python'
" Solirized colorscheme
Plugin 'altercation/vim-colors-solarized'
" Base16 colorscheme
Plugin 'chriskempson/base16-vim'
" ALE
Plugin 'w0rp/ale'
" Asyncrun
Plugin 'skywind3000/asyncrun.vim'
" Space-vim-dark colorscheme
Plugin 'liuchengxu/space-vim-dark'
" Code formatter
Plugin 'google/yapf'

call vundle#end()

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on

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
" use global scope search
let OmniCpp_GlobalScopeSearch = 1
" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 1
" 0 = auto
" 1 = always show all members
let OmniCpp_DisplayMode = 1
" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0
" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1
" This option can be use if you don't want to parse using namespace declarations in included files and want to add
" namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std"]
" Complete Behaviour
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0
" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can
" change this behaviour with the OmniCpp_SelectFirstItem option.
let OmniCpp_SelectFirstItem = 0
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
inoremap <S-Space> <Esc>
vnoremap <S-Space> <Esc>
snoremap <S-Space> <Esc>
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
" Syntastic configurations
"----------------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_aggregate_errors = 1
" close the error location list
"nnoremap <leader>ce :lclose<cr>
"let g:syntastic_python_checkers = ['python']

"----------------------------------------------------------------------
"
"----------------------------------------------------------------------
" Ale configurations
"----------------------------------------------------------------------
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_python_pylint_executable = 'python'
let g:pymode_python = 'python'

let g:ale_linters = {
            \   'python': ['flake8'],
            \}

" Run linters on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Unite configuration
"----------------------------------------------------------------------
nnoremap <C-p> :Unite file_rec/async<cr>
let g:unite_source_history_yank_enable = 1
" slect from previous yanks
nnoremap <c-y> :Unite history/yank<cr>
" quick switch buffer
nnoremap <c-s> :Unite -quick-match buffer<cr>
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

" -------------------------------------------------------------
" Python-mode
" -------------------------------------------------------------
let g:pymode_rope = 0
"
"" Documentation
"let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
"
" Linting
" Auto check on save
" let g:pymode_lint_write = 1
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_lint_cwindow = 0
let g:pymode_lint = 1

"
"" Support virtualenv
"let g:pymode_virtualenv = 0
"
"" Enable breakpoints plugin
""let g:pymode_breakpoint = 0
""let g:pymode_breakpoint_bind = '<leader>b'
"
"" syntax highlighting
" let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all

let g:pymode_folding = 0

" -------------------------------------------------------------

"
" Don't autofold code
"let g:pymode_folding = 0
"
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
let g:Tex_CustomTemplateDirectory = '~/templates'
let g:Tex_GotoError=0

" Edit commands for the navifation in help documents
nnoremap <C-9> :<C-]>

" Suppress message of vim-conda
let g:conda_startup_msg_suppress = 1
let g:jedi#force_py_version = 2
let g:UltisnipsUsePythonVersion = 2

" Setting for grammar check (Grammarous)
let g:grammarous#disabled_rules = {
            \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES', 'COMMA_PARENTHESIS_WHITESPACE'],
            \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
            \ }
" Use vim spellang
let g:grammarous#use_vim_spelllang = 1

" Jedi-Vim
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

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
