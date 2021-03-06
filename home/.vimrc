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
"
let $PATH = $HOME.'/bin:' . $PATH

"----------------------------------------------------------
" Neovim's Python provider
"----------------------------------------------------------
let g:python_host_prog  = $HOME.'/.virtualenvs/py2neovim/bin/python'
let g:python3_host_prog = $HOME.'/.virtualenvs/py3neovim/bin/python3'

" Disable ALE LSP features
let g:ale_disable_lsp = 1

" Pluggins
"{{{
"----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
"
" Hexeditor
" Plug 'd0c-s4vage/pfp-vim'
Plug 'fidian/hexmode'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Ultisnips
Plug 'SirVer/ultisnips'
" Own snippets
Plug 'cristobaltapia/MySnippets'
" vim-Grammarous
Plug 'rhysd/vim-grammarous'
" CSV files
" Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" Markdown preview support
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" reStructuredText preview
Plug 'Rykka/InstantRst', { 'for': 'rst' }
" vim-pandoc: Pandoc support
Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'markdown.pandoc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }
Plug 'godlygeek/tabular', { 'for': ['markdown', 'markdown.pandoc'] }
" Vim Easy Align
Plug 'junegunn/vim-easy-align'
" fugitive.vim: a Git wrappe
Plug 'tpope/vim-fugitive'
"APDL Syntax
Plug 'cristobaltapia/apdl.vim'
" Better file browser
Plug 'preservim/nerdtree'
" Code commenter
Plug 'tpope/vim-commentary'
" Vim-Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Autoclose (autocloses parenthesis)
Plug 'Townk/vim-autoclose'
" Fix white spaces at end of lines
Plug 'bronson/vim-trailing-whitespace'
" Matlab
Plug 'vim-scripts/MatlabFilesEdition', { 'for': 'matlab' }
" Latex
Plug 'lervag/vimtex', {'for': 'tex'}
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
" ALE
Plug 'dense-analysis/ale'
" COC
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
" Julia support
Plug 'JuliaEditorSupport/julia-vim'
" Julia formatter
Plug 'kdheepak/JuliaFormatter.vim'
" Vim-slime (for REPL of julia)
Plug 'jpalardy/vim-slime', { 'branch': 'main' }
" OpenScad support
Plug 'sirtaj/vim-openscad'
" Nginx support
Plug 'chr4/nginx.vim'
" Toml file support
Plug 'cespare/vim-toml'
" Asyncrun
Plug 'skywind3000/asyncrun.vim'
Plug 'elzr/vim-json', {'for': 'json'}
" Change working direcotry to open buffer
Plug 'yssl/AutoCWD.vim'
" A Vim plugin which shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'
" GPG integration
Plug 'jamessan/vim-gnupg'
" Wavefront format support
Plug 'vim-scripts/Wavefronts-obj'
" Vala plugin
Plug 'arrufat/vala.vim'
" SCAD support
Plug 'sirtaj/vim-openscad'
" Context
" Plug 'wellle/context.vim'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Goyo - distraction free writing
Plug 'junegunn/goyo.vim'
" Devicons
Plug 'ryanoasis/vim-devicons'
" Vim-sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" Follow symlinks
Plug 'moll/vim-bbye' " optional dependency
Plug 'aymericbeaumet/vim-symlink'
" Vimwiki
Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'
" Bullets
Plug 'dkarter/bullets.vim'
" Plug 'powerman/vim-plugin-AnsiEsc'
" Plug 'tbabej/taskwiki'
Plug 'matt-snider/vim-tagquery', { 'do': 'bash install.sh' }
" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

"--------
" Python:
"--------
" Semshi: semantic highlight for python
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
" REPL
" Plug 'Vigemus/iron.nvim'
" Indent text object
Plug 'michaeljsmith/vim-indent-object', { 'for': 'python' }

"--------
" Colors:
"--------
" Solirized colorscheme
Plug 'lifepillar/vim-solarized8'
" Gruvbox colorscheme
Plug 'morhetz/gruvbox'
" Oceanic-next colorscheme
Plug 'mhartington/oceanic-next'
" Base16 colorscheme
Plug 'chriskempson/base16-vim'
" Seoul256 color theme
Plug 'junegunn/seoul256.vim'
" Nord colorscheme
" Plug 'arcticicestudio/nord-vim'
Plug 'mrswats/nord-vim', { 'branch': 'treesitter-support' }

call plug#end()
"}}}

" Latex options (I need this or nothing works... but don't ask why :/)
let g:tex_flavor='latex'
filetype plugin on
syntax on

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
set breakindentopt=min:20,shift:0,sbr
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
set shada+=r/mnt/intcdc

" For conceal markers.
if has('conceal')
    set conceallevel=0 concealcursor=niv
endif

" Visual selection automatically copies to the clipboard
set clipboard+=unnamedplus
set guioptions-=m  " Remove menu bar
set guioptions-=T  " Remove toolbar

" Edit commands for the navifation in help documents
nnoremap <C-9> <C-]>

" For the matchup plugin
let g:matchup_surround_enabled = 1

" Correct spelling
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

"}}}

"----------------------------------------------------------------------
" Colors for neovim
"----------------------------------------------------------------------
"{{{
" configure nvcode-color-schemes
let g:nvcode_termcolors=256

set background="dark"
colorscheme nord
let g:airline_theme='nord'

" Fix colors within tmux
if (empty("$TMUX"))
    " set notermguicolors
    if (has("nvim"))
        set termguicolors
    endif
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
    autocmd FileType markdown setlocal spell
    autocmd FileType wiki set spell
    autocmd FileType pandoc-markdown setlocal spell
    autocmd BufEnter,BufNewFile,BufNew *.py setlocal nospell
    autocmd BufRead,BufEnter,BufNewFile */Notes/* setlocal nospell
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
    autocmd FileType markdown setlocal
                \ shiftwidth=2
                \ tabstop=2
                \ softtabstop=2
                \ expandtab
    autocmd FileType markdown.pandoc setlocal
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
    autocmd FileType bash setlocal
                \ shiftwidth=2
                \ tabstop=2
    autocmd FileType sh setlocal
                \ shiftwidth=2
                \ tabstop=2
    autocmd FileType vimwiki setlocal
                \ shiftwidth=4
                \ tabstop=4
                \ softtabstop=4
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
    " set guifont=Fira\ Code:h11
    " set guifont=FuraCode\ Nerd\ Font\ Medium:h11
    set guifont=JuliaMono\ Nerd\ Font:h11
endif

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Cooperation with Asyncrun
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
"}}}

"----------------------------------------------------------------------
" Python configuration
"----------------------------------------------------------------------
"{{{

filetype on
syntax on
let python_highlight_all=1

"}}}

"----------------------------------------------------------------------
" Configuration for vim-easy-align
"----------------------------------------------------------------------
"{{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <leader><cr> <Plug>(EasyAlign)

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
" Vim-session
"----------------------------------------------------------------------
let g:session_autoload="no"
let g:session_autosave="no"
"
"----------------------------------------------------------------------
" Ale configurations
"----------------------------------------------------------------------
" {{{ "
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
            \   'python': ['pylint'],
            \   'tex': ['chktex', 'proselint', 'lacheck', 'write-good', 'redpen'],
            \   'fortran': ['gcc'],
            \   'markdown': ['alex', 'proselint', 'languagetool'],
            \   'wiki': ['languagetool'],
            \   'javascript': ['javac'],
            \   'dockerfile': ['hadolint'],
            \}

let g:ale_fixers = {
            \   'python': ['black', 'isort'],
            \   'tex': ['remove_trailing_lines', 'latexindent'],
            \   'markdown': ['prettier'],
            \   'javascript': ['prettier'],
            \   'bib': ['bibclean'],
            \   'json': ['prettier'],
            \   'vim': ['trim_whitespace'],
            \}

let g:ale_languagetool_options="--autoDetect --languagemodel ~/.local/share/languagetool/ngrams"

" call deoplete#custom#source('ale', 'rank', 999)

" Define map for the Fix function
noremap <LocalLeader>= :ALEFix<cr>

" Change default symbols for ALE
let g:ale_sign_error = ">>"
let g:ale_sign_warning = ">>"
" }}} "
let g:ale_bib_bibclean_options = '-align-equals -fix-font-changes -German-style'


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
" nnoremap <Leader>cq :ccl<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
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
    elseif &filetype == 'julia'
        exec "AsyncRun julia %:p"
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
function! g:Open_browser(url)
    silent exe 'silent !epiphany --private-instance ' . a:url . " &"
endfunction
let g:mkdp_browserfunc = 'g:Open_browser'
let g:mkdp_filetypes = ['markdown', 'markdown.pandoc']

autocmd FileChangedShell <buffer> call ProcessFileChangedShell()

let g:mkdp_auto_close = 0
"}}}

"----------------------------------------------------------------------
" AutCWD
"----------------------------------------------------------------------
"{{{
" Auto-change working directory to current buffer
let g:autocwd_patternwd_pairs = [
            \['*.vim', '%:p:h'],
            \['*.py', '%:p:h'],
            \['*.tex', '%:p:h'],
            \['*', '%:p:h'],
            \]

"}}}
"----------------------------------------------------------------------
" Gitgutter
"----------------------------------------------------------------------
"{{{
let g:gitgutter_max_signs = 500     " default value

nnoremap <Leader>dc :GitGutterPreviewHunk<CR>
nnoremap <Leader>gs :GitGutterStageHunk<CR>
nnoremap <Leader>gn :GitGutterNextHunk<CR>

"}}}
"----------------------------------------------------------------------
"----------------------------------------------------------------------
" Vimtex
"----------------------------------------------------------------------
let g:vimtex_compiler_progname=$HOME.'/.virtualenvs/py3neovim/bin/nvr'

"----------------------------------------------------------------------
" Vim-Pandoc
"----------------------------------------------------------------------
"{{{
" let g:pandoc#modules#disabled = ["command"]
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#filetypes#pandoc_markdown = 1

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
"

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

"}}}
"

"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------
" {{{ "
" This is redifined in the coc.nvim config
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=[
            \'UltiSnips',
            \$HOME.'/.vim/plugged/MySnippets/Ultisnips',
            \$HOME.'/Templates/ultisnips-templates'
            \]

" Set the smart function definition to use numpy style for docstrings
let g:ultisnips_python_style="numpy"
let g:UltisnipsUsePythonVersion = 3
" }}} "

set cmdheight=2
let g:echodoc_enable_at_startup = 1

"
"----------------------------------------------------------------------
"COC configurations
"----------------------------------------------------------------------
" {{{ "

" Install all coc-extensions
" let g:coc_global_extensions = [
"             \ 'coc-texlab',
"             \ 'coc-pyright',
"             \ 'coc-tsserver',
"             \ 'coc-highlight',
"             \ 'coc-html',
"             \ 'coc-ultisnips',
"             \ 'coc-yank',
"             \ 'coc-lists',
"             \ 'coc-git',
"             \ 'coc-json',
"             \ 'coc-vimlsp',
"             \ 'coc-yaml',
"             \ 'coc-css',
"             \ 'coc-markdownlint',
"             \ 'coc-omnisharp'
"             \ ]

"
"" if hidden is not set, TextEdit might fail.
set hidden

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Solves double 'Enter' needed for a new line
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"
inoremap <silent><expr> <C-l> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
" Call CocCommands
nnoremap <silent> <leader>cc  :<C-u>CocCommand<CR>

" Use <C-l> for trigger snippet expand.
" imap <C-k> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-n> <Plug>(coc-snippets-expand-jump)

" autocmd FileType python nnoremap <F5> :call CocActionAsync('runCommand',
"             \ 'python.execInTerminal')<CR>

nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" Correct highlight of comments in json files
autocmd FileType json syntax match Comment +\/\/.\+$+

" }}} "

"----------------------------------------------------------------------
" Julia
"----------------------------------------------------------------------
" {{{ "
" autocmd FileType julia nnoremap <S-F5> :call <SID>compile_and_run()<CR>
autocmd FileType,BufEnter,BufNewFile,BufNew julia set foldmethod=syntax
let latex_to_unicode_tab = 0
let g:latex_to_unicode_suggestions = 1
let g:latex_to_unicode_eager = 1
let g:latex_to_unicode_auto = 1

let g:JuliaFormatter_options = {
            \ 'style' : 'blue',
            \ }

function SendJuliaRange()
    let l:curr_buff = getbufinfo({'curr':0})
    let l:curr_line = curr_buff['curr'].lnum
    execute "0," . curr_line . "SlimeSend"
endfunction

augroup juliacmd
    autocmd!
    autocmd FileType,BufEnter julia nnoremap <F5> :SlimeSend0 'includet("' . expand('%:p') . '")' . "\r"<CR>
    autocmd FileType,BufEnter julia nnoremap <F6> :call SendJuliaRange()<CR>
    autocmd FileType,BufEnter julia nnoremap <F7> :SlimeSend0 'include("' . expand('%:p') . '")' . "\r"<CR>
    autocmd FileType,BufEnter julia command! -nargs=0 Format :JuliaFormatterFormat
augroup END
" }}} "

"----------------------------------------------------------------------
" Vim -slime
" set slime target (tmux instead of screen)
let g:slime_target = "tmux"
" set target pane that code is sent to (optional)
let g:slime_default_config = {"socket_name": "default", "target_pane": "0.1"}


" Close the terminal split below after the execution of the file
" autocmd TermOpen * startinsert
augroup close_lower_window
    autocmd!
    autocmd FileType,BufEnter,BufNewFile,BufNew python nnoremap <Leader>cq <C-w>j:bd!<cr>
    autocmd FileType,BufEnter,BufNewFile,BufNew tex nnoremap <Leader>cq :ccl<cr>
    autocmd FileType,BufEnter,BufNewFile,BufNew julia nnoremap <Leader>cq :ccl<cr>
augroup END

" Refresh the syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

"----------------------------------------------------------------------
" bullets {{{ "
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'markdown.pandoc',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch',
            \ 'wiki'
            \]

let g:bullets_nested_checkboxes = 1
let g:bullets_set_mappings = 1

" }}} bullets "
"
"----------------------------------------------------------------------
" wiki.vim configuration {{{ "
" Notes with vimwiki
" autocmd FileType vimwiki set ft=markdown
let g:vimwiki_pubs_config = [$HOME."/.config/pubs/main_library.conf", $HOME."/.config/pubs/misc_library.conf"]

let g:wiki_root = '~/Notes'
let g:wiki_map_link_create = 'WikivimFile'
let g:wiki_mappings_global = {
            \ '<plug>(wiki-list-toggle)' : '<c-d>',
            \ 'i_<plug>(wiki-list-toggle)' : '<c-d>',
            \}

function WikivimFile(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

augroup MyWikiAutocmds
    autocmd!
    autocmd Filetype wiki set nofoldenable
                \ conceallevel=0
                \ wrap
                \ concealcursor=nv
    autocmd Filetype wiki nmap <leader>wse <Plug>(wiki-fzf-tags)
    autocmd Filetype wiki nmap <leader>wsp <Plug>(wiki-fzf-pages)
augroup end

" }}} Vimwiki configuration "

"----------------------------------------------------------------------
" tmux configuration {{{ "
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
" }}} tmux configuration "

"----------------------------------------------------------------------
" Context
let g:context_add_mappings = 1
let g:context_nvim_no_redraw = 1
let g:context_highlight_normal = 'PMenu'
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Goyo
autocmd BufLeave goyo_pad setlocal norelativenumber nonumber
let g:numbers_exclude = ['goyo_pad']
"----------------------------------------------------------------------
