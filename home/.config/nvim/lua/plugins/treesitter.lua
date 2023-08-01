return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = {
        "bash",
        "bibtex",
        "comment",
        "css",
        "dockerfile",
        "javascript",
        "json",
        "julia",
        "lua",
        "python",
        "query",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "yuck",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
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
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',             -- charwise
            ['@function.outer'] = 'V',              -- linewise
            ['@class.outer'] = 'V',                 -- blockwise
          },
          include_surrounding_whitespace = false,
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- Foldings
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldnestmax = 2
      vim.opt.foldenable = false

      vim.cmd('hi pythonTSParameter guifg=#b48ead')
      vim.cmd('hi TSConstant guifg=#ebcb8b')

    end
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", },
  { 'nvim-treesitter/playground' },
}
-- vim: set shiftwidth=2:
