set runtimepath^=~/.vim,~/.vim/after
set packpath+=~/.vim

if empty(glob("~/.vim/autoload/plug.vim"))
    execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

source ~/.vimrc

" Movements in term-mode

" Escape terminal mode with <Esc>
tnoremap <Esc> <C-\><C-n>
" Move in any mode with <Alt> + {h,j,k,l}
" tnoremap <A-h> <C-\><C-n><C-w>h
" tnoremap <A-j> <C-\><C-n><C-w>j
" tnoremap <A-k> <C-\><C-n><C-w>k
" tnoremap <A-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175

" Treesitter {{{1 "
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "julia", "latex", "bash", "yaml", "bibtex", "css", "json", "javascript", "toml"},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

hi pythonTSParameter guifg=#b48ead
hi TSConstant guifg=#ebcb8b

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" 1}}} "
