-- Set spelling
vim.cmd('syntax spell toplevel')
vim.opt_local.spell = true

vim.keymap.set("n", "<localleader>ll", "<Plug>(vimtex-compile-ss)")
vim.keymap.set("v", "<localleader>ll", "<Plug>(vimtex-compile-selected)")
vim.keymap.set("n", "<localleader>lv", "<Plug>(vimtex-view)")
vim.keymap.set("n", "<localleader>lo", "<Plug>(vimtex-compile-output)")
vim.keymap.set("n", "<localleader>rf", vim.cmd.VimtexRefreshFolds)
-- nnorvim.keymap.set("e", "<localleader>lt", :call vimtex#fzf#run('cl')<cr>

vim.g.tex_flavor = 'latex'

vim.g.vimtex_compiler_latexmk = {
    build_dir = 'aux-folder',
    callback = 1,
    continuous = 0,
    executable = 'latexmk',
    options = { '-verbose',
        '-shell-escape',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

vim.g.vimtex_compiler_latexmk_engines = { _ = '-lualatex' }

vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_complete_close_braces = 0
vim.g.vimtex_complete_ignore_case = 1
vim.g.vimtex_complete_smart_case = 1
vim.g.vimtex_fold_enabled = 1

vim.g.vimtex_syntax_conceal = {
    accents = 1,
    ligatures = 0,
    cites = 1,
    fancy = 0,
    spacing = 0,
    greek = 0,
    math_bounds = 0,
    math_delimiters = 0,
    math_fracs = 0,
    math_super_sub = 0,
    math_symbols = 1,
    sections = 0,
    styles = 1,
}

-- vim.l.concealcursor = ''

vim.g.vimtex_indent_enabled = true
vim.g.vimtex_indent_on_ampersands = false
vim.g.vimtex_indent_bib_enabled = true

vim.g.vimtex_imaps_leader = '#'
vim.g.vimtex_quickfix_method = 'latexlog'
vim.g.matchup_override_vimtex = true
vim.g.vimtex_compiler_progname = vim.env.HOME .. '/.virtualenvs/py3neovim/bin/nvr'

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_forward_search_on_start = true

vim.g.vimtex_echo_verbose_input = 0

vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
vim.g.vimtex_quickfix_open_on_warning = 0

-- Delimiter modifiers
vim.g.vimtex_delim_toggle_mod_list = {
    { '\\left',  '\\right' },
    { '\\mleft', '\\mright' },
}

