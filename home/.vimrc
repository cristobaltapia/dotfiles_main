"
" Vim configuration file
" Author: Cristóbal Tapia Camú
"
" Load vim-plug
" if has('win32')
"     " this does not work, but I leave it here just to remember what I need to do
"     if empty(glob("~/vimfiles/autoload/plug.vim"))
"         execute 'md ~\vimfiles\autoload'
"         execute "$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
"         execute '(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\autoload\plug.vim"))'
"     endif
" endif
"
" if has('vim')
"     if empty(glob("~/.vim/autoload/plug.vim"))
"         execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
"     endif
" endif

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

"----------------------------------------------------------------------
" Function to get OS
"----------------------------------------------------------------------
"{{{
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if system('uname -r')=~# 'arch'
      return "Arch"
    else
      return "Ubuntu"
    endif
  endif
endfunction

let curr_os = GetRunningOS()
"}}}

"----------------------------------------------------------
" Neovim's Python provider
"----------------------------------------------------------
let g:python_host_prog  = $HOME.'/.virtualenvs/py2neovim/bin/python'
let g:python3_host_prog = $HOME.'/.virtualenvs/py3neovim/bin/python3'

" Pluggins
"{{{
"----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
"
" Hexeditor
" Plug 'd0c-s4vage/pfp-vim'
Plug 'fidian/hexmode'
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
" CSV files
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" Virtualenv support
" Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
" Plug 'tpict/vim-virtualenv', { 'for': 'python', 'commit': 'c9a52e5' }
Plug 'cristobaltapia/vim-virtualenv', { 'for': 'python' }
" Markdown preview support
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" vim-pandoc: Pandoc support
Plug 'vim-pandoc/vim-pandoc', { 'for': 'markdown' }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }
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
" Plug 'mattn/emmet-vim'
" Vim-Airline
Plug 'bling/vim-airline'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Autoclose (autocloses parenthesis)
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object', { 'for': 'python' }
" Fix white spaces at end of lines
Plug 'bronson/vim-trailing-whitespace'
" Matlab
Plug 'vim-scripts/MatlabFilesEdition', { 'for': 'matlab' }
" Latex
Plug 'lervag/vimtex', {'for': 'tex' }
" Convert latex expressions into unicode equivalents
Plug 'joom/latex-unicoder.vim'
" Rename. Rename a buffer within Vim and on disk
Plug 'vim-scripts/Rename'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
Plug 'andymass/vim-matchup'
" " Numbers (relative numbers)
Plug 'myusuf3/numbers.vim'
" Vim indent guides (colors!)
Plug 'nathanaelkane/vim-indent-guides'
" Solirized colorscheme
Plug 'altercation/vim-colors-solarized'
" Oceanic-next colorscheme
Plug 'mhartington/oceanic-next'
" Base16 colorscheme
Plug 'chriskempson/base16-vim'
" Seoul256 color theme
Plug 'junegunn/seoul256.vim'
" ALE
Plug 'w0rp/ale'
" Nginx support
Plug 'chr4/nginx.vim'
" Asyncrun
Plug 'skywind3000/asyncrun.vim'
" Nord colorscheme
Plug 'arcticicestudio/nord-vim'
" vim-jason: a better json
Plug 'elzr/vim-json', {'for': 'json'}
" Jedi-vim
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'blueyed/jedi-vim', { 'branch': 'envs', 'for': 'python' }
" Change working direcotry to open buffer
Plug 'yssl/AutoCWD.vim'
" A Vim plugin which shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'
" GPG integration
Plug 'jamessan/vim-gnupg'
" Wavefront format support
Plug 'vim-scripts/Wavefronts-obj'
" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim', { 'for': ['tex', 'txt', 'md'] }
" Deoplete (completion)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"
Plug 'Shougo/echodoc.vim'
"
" Plug 'ncm2/float-preview.nvim'
" Jedi for deoplete
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
" Vala plugin
Plug 'arrufat/vala.vim'
" Ipython terminal
" Plug 'hkupty/iron.nvim', { 'for': 'python' }

call plug#end()
"}}}

" Latex options (I need this or nothing works... but don't ask why :/)
let g:tex_flavor='latex'

" Change direcotry to folder of opened file
cd %:p:h

"----------------------------------------------------------------------
" Options and mappings
"----------------------------------------------------------------------
"{{{
set title           " Toggle title on
set titlestring=%t%(\ %M%)%(\ %y%)  " Set the title string
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
set diffopt+=vertical " Set vertical split as default for diff
let $PYTHONUNBUFFERED=1 " See python real-time output

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

" Edit commands for the navifation in help documents
nnoremap <C-9> <C-]>

" For the matchup plugin
let g:matchup_surround_enabled = 1

inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

"}}}

"----------------------------------------------------------------------
" Colors for GVim
"----------------------------------------------------------------------
"{{{
if has('gui_running')
    " colorscheme space-vim-dark
    " colorscheme OceanicNext
    let g:seoul256_background=234
    colorscheme seoul256
elseif has('nvim')
    " colorscheme space-vim-dark
    " colorscheme OceanicNext
    " let g:seoul256_background=234
    " colorscheme seoul256
    colorscheme nord
endif
"}}}


"----------------------------------------------------------------------
" Mappings
"----------------------------------------------------------------------
"{{{
" Map to stop highlighting of last search
nnoremap <leader>pp :nohlsearch<cr>

" Folding remaping
nnoremap <space> za
vnoremap <space> zf

" Map <Esc> to Shift-Space. Its more confortable
inoremap <S-Space> <Esc>
vnoremap <S-Space> <Esc>
snoremap <S-Space> <Esc>

inoremap <M-Space> <Esc>
vnoremap <M-Space> <Esc>
snoremap <M-Space> <Esc>

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
"}}}

"----------------------------------------------------------------------
" Functions
"----------------------------------------------------------------------
"{{{
" Copy all matches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
"}}}
"

"----------------------------------------------------------------------
" Tablength exceptions
"----------------------------------------------------------------------
"{{{
augroup spell_group
    autocmd!
    autocmd BufEnter,BufNewFile,BufNew *.tex syntax spell toplevel
    autocmd BufEnter,BufNewFile,BufNew *.tex setlocal spell
    autocmd BufEnter,BufNewFile,BufNew *.md setlocal spell
augroup END

augroup file_type
    autocmd!
    autocmd FileType python AirlineRefresh
    autocmd FileType python setlocal
                \ shiftwidth=4
                \ tabstop=4
                \ softtabstop=4
                \ expandtab
    autocmd FileType html setlocal
                \ shiftwidth=2
                \ tabstop=2
    autocmd FileType htmldjango setlocal
                \ shiftwidth=2
                \ tabstop=2
    autocmd FileType javascript setlocal
                \ shiftwidth=2
                \ tabstop=2
    autocmd FileType tex AirlineRefresh
    autocmd FileType tex setlocal
                \ shiftwidth=2
                \ tabstop=2
                \ softtabstop=2
                \ expandtab
    autocmd FileType fortran setlocal
                \ shiftwidth=3
                \ tabstop=3
                \ softtabstop=3
                \ expandtab
    autocmd FileType yaml setlocal
                \ ts=2
                \ sts=2
                \ sw=2
                \ expandtab
augroup END

"}}}

"----------------------------------------------------------------------
" Toggle Tagbar display
"----------------------------------------------------------------------
noremap <F4> :TagbarToggle<CR>
" Autofocus on Tagbar open
let g:tagbar_autofocus = 1

"----------------------------------------------------------------------
" Automatically close autocompletion window
"----------------------------------------------------------------------
augroup autocompl_window
    autocmd!
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

"----------------------------------------------------------------------
" Rainbow parentheses
"----------------------------------------------------------------------
"{{{
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
            \        'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \    'html': {
            \        'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \    'css': 0,
            \   }
            \}
"}}}

"----------------------------------------------------------------------
" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>
" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Powerline configurations
"----------------------------------------------------------------------
"{{{
"let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
if has('win32')
    set guifont=Source\ Code\ Pro\ for\ Powerline:h10
elseif has('vim')
    set guifont=Noto\ Mono\ for\ Powerline
elseif has('nvim')
    set guifont=Fira\ Code:h11
endif

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Enable virtualenv integration
let g:airline#extensions#virtualenv#enabled = 1
let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv', '.virtualenv']
" Cooperation with Asyncrun
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
"}}}

"----------------------------------------------------------------------
" Snippets and autocompletion
"----------------------------------------------------------------------
"{{{
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
            \'UltiSnips',
            \$HOME.'/.vim/plugged/MySnippets/Ultisnips',
            \$HOME.'/Templates/ultisnips-templates'
            \]
"
" Set the smart function definition to use numpy style for docstrings
let g:ultisnips_python_style="numpy"

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
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"     return deoplete#close_popup() . "\<CR>"
" endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

set completeopt="menu,preview,menuone"
set cmdheight=2
let g:echodoc_enable_at_startup = 1

" let g:float_preview#docked = 1

"}}}

"----------------------------------------------------------------------
" Python configuration
"----------------------------------------------------------------------
"{{{
"
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

filetype on
syntax on
let python_highlight_all=1

"-------------------------------------------------------------
" Jedi-vim
"-------------------------------------------------------------
" let g:deoplete#sources#jedi#extra_path = ""
let g:deoplete#sources#jedi#server_timeout = 30
let g:deoplete#sources#jedi#show_docstring=0
let g:deoplete#sources#jedi#python_path = $HOME.'/.virtualenvs/py3neovim/bin/python3'

set shortmess+=c
"}}}

"----------------------------------------------------------------------
" Configuration for vim-easy-align
"----------------------------------------------------------------------
"{{{
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
"}}}

"----------------------------------------------------------------------
" Ale configurations
"----------------------------------------------------------------------
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
            \   'python': ['pylint'],
            \   'tex': ['chktex', 'proselint', 'lacheck', 'write-good'],
            \   'fortran': ['gcc'],
            \   'markdown': ['alex', 'proselint'],
            \   'javascript': ['javac'],
            \   'dockerfile': ['hadolint'],
            \}

" Run linters on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" linters run on opening a file
let g:ale_lint_on_enter = 1
let g:ale_linters_explicit = 1
" let g:ale_completion_enabled = 1
let g:ale_virtualtext_cursor = 0

let g:ale_fixers = {
            \   'python': ['black', 'isort'],
            \   'tex': ['remove_trailing_lines', 'latexindent'],
            \   'markdown': ['prettier'],
            \   'javascript': ['prettier'],
            \   'bib': ['bibclean'],
            \   'json': ['prettier'],
            \}
" let g:ale_python_yapf_executable = 'yapf --style="{based_on_style: pep8; SPLIT_BEFORE_NAMED_ASSIGNS: False, DEDENT_CLOSING_BRACKETS: False}"'

" Define map for the Fix function
noremap <LocalLeader>= :ALEFix<cr>

" Change default symbols for ALE
let g:ale_sign_error = ">>"
let g:ale_sign_warning = ">>"
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
"----------------------------------------------------------------------
"{{{
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
"}}}

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

" autocmd FileChangedShell <buffer> call ProcessFileChangedShell()

"----------------------------------------------------------------------
" Markdown
"----------------------------------------------------------------------
"{{{
let g:markdown_composer_browser='epiphany --private-instance'
let g:markdown_composer_open_browser=0
let g:markdown_composer_refresh_rate=0
" let g:markdown_composer_syntax_theme='solarized_dark'
let g:markdown_composer_external_renderer='pandoc '
" \.'--filter pandoc-citeproc '
            \.'-f markdown -t html'

autocmd FileChangedShell <buffer> call ProcessFileChangedShell()
"}}}

"----------------------------------------------------------------------
" AutCWD
"----------------------------------------------------------------------
" Auto-change working directory to current buffer
let g:autocwd_patternwd_pairs = [
            \['*.vim', '%:p:h'],
            \['*.py', '%:p:h'],
            \['*.tex', '%:p:h'],
            \['*', '%:p:h'],
            \]

"----------------------------------------------------------------------
" Gitgutter
"----------------------------------------------------------------------
let g:gitgutter_max_signs = 500     " default value

"----------------------------------------------------------------------
" Goyo
"----------------------------------------------------------------------
function! s:goyo_enter()
    NumbersToggle
    set nonumber
    " ...
endfunction

function! s:goyo_leave()
    NumbersToggle
    set nu
    " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"----------------------------------------------------------------------
" Vim-Pandoc
"----------------------------------------------------------------------
" let g:pandoc#modules#disabled = ["command"]
let g:pandoc#syntax#conceal#use = 0

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
"
" Deoplete integration
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'pandoc': '@'
            \})

let g:pandoc#command#custom_open = "MyPandocOpen"

function! MyPandocOpen(file)
    let file = shellescape(fnamemodify(a:file, ':p'))
    let file_extension = fnamemodify(a:file, ':e')
    if file_extension is? 'pdf'
        if !empty($PDFVIEWER)
            return expand('$PDFVIEWER') . ' ' . file
        elseif executable('zathura')
            return 'zathura ' . file
        elseif executable('mupdf')
            return 'mupdf ' . file
        endif
    elseif file_extension is? 'html'
        if !empty($BROWSER)
            return expand('$BROWSER') . ' ' . file
        elseif executable('firefox')
            return 'firefox ' . file
        elseif executable('chromium')
            return 'chromium ' . file
        endif
    elseif file_extension is? 'odt' && executable('okular')
        return 'okular ' . file
    elseif file_extension is? 'epub' && executable('okular')
        return 'okular ' . file
    else
        return 'xdg-open ' . file
    endif
endfunction

" if executable($HOME.'/.virtualenvs/py3neovim/bin/pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->[$HOME.'/.virtualenvs/py3neovim/bin/pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif
