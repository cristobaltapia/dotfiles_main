-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Colorschemes
    use {
        'shaunsingh/nord.nvim',
        as = 'nord',
        config = function()
            vim.cmd('colorscheme nord')
        end
    }
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = vim.cmd.TSUpdate }
    use { 'nvim-treesitter/playground' }
    -- Undo history
    use { 'mbbill/undotree' }
    -- Git support
    use { 'tpope/vim-fugitive' }
    use { 'airblade/vim-gitgutter' }
    -- Language server and related
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { "folke/neodev.nvim" },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-omni' },
            { 'quangnguyen30192/cmp-nvim-ultisnips' },
        }
    }
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    }
    -- Snippets
    use { 'SirVer/ultisnips',
        requires = {
            { 'honza/vim-snippets' },
            { 'cristobaltapia/MySnippets' }
        }
    }
    -- Makde char-based diffs (usefull for latex documents and similar)
    use { 'rickhowe/diffchar.vim',
        ft = { 'markdown', 'markdown.pandoc', 'tex' }
    }
    use { 'b3nj5m1n/kommentary', branch = 'main' }
    --[[ use { 'vim-airline/vim-airline' }
    use { 'vim-airline/vim-airline-themes' } ]]
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Surround movements
    use { 'tpope/vim-surround' }
    -- Close pairs of parentheses, quotes, etc
    use { 'windwp/nvim-autopairs' }
    -- Different nice improvements for neovim
    use { 'echasnovski/mini.nvim', branch = 'main' }
    -- Change to directory of current edited file
    use { 'yssl/AutoCWD.vim' }
    -- Support for openning GNUGP excrypted files
    use { 'jamessan/vim-gnupg' }
    -- FZF support
    use { 'junegunn/fzf', run = './install --all' }
    use { 'junegunn/fzf.vim' }
    -- Nice icons
    use { 'ryanoasis/vim-devicons' }
    -- Note-taking utilities
    use { 'lervag/wiki.vim' }
    use { 'lervag/wiki-ft.vim' }
    use { 'dkarter/bullets.vim' }
    -- Integration with tmux
    use { 'christoomey/vim-tmux-navigator' }
    -- Integration with jupyter
    use { 'untitled-ai/jupyter_ascending.vim', ft = { 'python' } }
    use { 'kana/vim-textobj-user' }
    use { 'GCBallesteros/vim-textobj-hydrogen' }
    -- Integration with latex
    use { 'lervag/vimtex', ft = { 'tex' } }
    use { 'joom/latex-unicoder.vim' }
    -- Support for typst
    use { 'kaarmu/typst.vim', branch = 'main' }
    -- Enable asyncronous run of commands
    use { 'skywind3000/asyncrun.vim' }
    -- Nice visualization of quickfix errors
    use { 'kevinhwang91/nvim-bqf' }
    -- Support for markdown
    use { 'vim-pandoc/vim-pandoc', ft = { 'markdown', 'markdown.pandoc' },
        requires = {
            { 'vim-pandoc/vim-pandoc-syntax' },
            { 'godlygeek/tabular' }
        }
    }
end)
