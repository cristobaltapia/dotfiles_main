return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- Colorschemes
    {
        'shaunsingh/nord.nvim',
        name = 'nord',
        config = function()
            vim.cmd('colorscheme nord')
        end
    },
    { 'rose-pine/neovim',                name = 'rose-pine' },
    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = vim.cmd.TSUpdate },
    { 'nvim-treesitter/playground' },

    -- Undo history
    { 'mbbill/undotree' },
    -- Git support
    { 'tpope/vim-fugitive' },
    { 'airblade/vim-gitgutter' },
    -- Language server and related
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'mason' },
            { 'neovim/nvim-lspconfig' }, -- Required
            { "folke/neodev.nvim" },
            -- Autocompletion
            { "nvim-cmp" },
        }
    },
    {
        'williamboman/mason-lspconfig.nvim',
        name = "mason",
        dependencies = {
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
        }
    },
    { 'hrsh7th/nvim-cmp',                     name = "nvim-cmp" },
    { 'hrsh7th/cmp-buffer',                   dependencies = "nvim-cmp" },
    { 'hrsh7th/cmp-path',                     dependencies = "nvim-cmp" },
    { 'hrsh7th/cmp-nvim-lsp',                 dependencies = "nvim-cmp" },
    { 'hrsh7th/cmp-nvim-lsp-signature-help',  dependencies = "nvim-cmp" },
    { 'hrsh7th/cmp-omni',                     dependencies = "nvim-cmp" },
    { 'quangnguyen30192/cmp-nvim-ultisnips',  dependencies = "nvim-cmp" },
    { 'L3MON4D3/LuaSnip' },
    -- Snippets
    {
        'SirVer/ultisnips',
        dependencies = {
            { 'honza/vim-snippets' },
            { 'cristobaltapia/MySnippets' }
        }
    },
    -- Better display of errors
    {
        "folke/trouble.nvim",
        dependencies = "web-devicons",
    },
    { "nvim-tree/nvim-web-devicons", name = "web-devicons" },
    -- Better ui elements for nvim
    { 'stevearc/dressing.nvim' },
    -- Follow symlinks
    -- { 'aymericbeaumet/vim-symlink',  dependencies = { 'moll/vim-bbye' } },
    -- Make char-based diffs (usefull for latex documents and similar)
    {
        'rickhowe/diffchar.vim',
        ft = { 'markdown', 'markdown.pandoc', 'tex' }
    },
    { 'b3nj5m1n/kommentary',           branch = 'main' },
    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    -- Surround movements
    { 'tpope/vim-surround' },
    -- Close pairs of parentheses, quotes, etc
    { 'windwp/nvim-autopairs' },
    -- Different nice improvements for neovim
    { 'echasnovski/mini.nvim',         branch = 'main' },
    -- Change to directory of current edited file
    { 'yssl/AutoCWD.vim' },
    -- Support for openning GNUGP excrypted files
    { 'jamessan/vim-gnupg' },
    -- FZF support
    { 'junegunn/fzf',                  build = './install --all' },
    { 'junegunn/fzf.vim' },
    -- Note-taking utilities
    { 'lervag/wiki.vim' },
    { 'lervag/wiki-ft.vim' },
    { 'dkarter/bullets.vim' },
    -- Integration with tmux
    { 'christoomey/vim-tmux-navigator' },
    -- Integration with jupyter
    {
        'untitled-ai/jupyter_ascending.vim',
        event = "BufEnter *.sync.py",
        config = function()
            -- Delete default key bindings
            vim.keymap.del("n", "<space><space>x")
            vim.keymap.del("n", "<space><space>X")
            vim.keymap.del("n", "<space><space>r")
            -- Define new key bindings
            vim.keymap.set("n", "<leader><leader>x", "<Plug>JupyterExecute")
            vim.keymap.set("n", "<leader><leader>X", "<Plug>JupyterExecuteAll")
            vim.keymap.set("n", "<leader><leader>r", "<Plug>JupyterRestart")
        end
        ,
        dependencies = {
            { 'kana/vim-textobj-user' },
            { 'GCBallesteros/vim-textobj-hydrogen' },
        }
    },
    -- Integration with latex
    { 'lervag/vimtex',           ft = { 'tex' } },
    { 'joom/latex-unicoder.vim' },
    -- Support for typst
    { 'kaarmu/typst.vim',        branch = 'main' },
    -- Enable asyncronous run of commands
    { 'skywind3000/asyncrun.vim' },
    -- Nice visualization of quickfix errors
    { 'kevinhwang91/nvim-bqf' },
    -- Support for markdown
    {
        'vim-pandoc/vim-pandoc',
        ft = { 'markdown', 'markdown.pandoc', 'pandoc' },
        dependencies = {
            { 'vim-pandoc/vim-pandoc-syntax' },
            { 'godlygeek/tabular' },
            {
                "iamcco/markdown-preview.nvim",
                build = function() vim.fn["mkdp#util#install"]() end,
                ft = { 'markdown', 'pandoc', 'markdown.pandoc' }
            }
        }
    },
}
