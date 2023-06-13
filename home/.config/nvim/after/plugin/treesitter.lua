require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "lua", "vim", "yaml", "bash", "bibtex", "css", "json", "toml", "vimdoc", "query", "javascript",
        "python", "julia", "dockerfile" , "comment", "yuck" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        -- disable = { "c", "rust" },
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        colors = {
            "#eceff4",
            "#88c0d0",
            "#ebcb8b",
            "#81a1c1",
            "#d08770",
        },
        -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        extended_mode = false,
        -- Do not enable for files with more than 1000 lines, int
        max_file_lines = 1000,
    },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 2
