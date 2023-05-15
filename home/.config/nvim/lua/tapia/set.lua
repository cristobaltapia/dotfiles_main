vim.g.python3_host_prog = vim.env.HOME .. '/.virtualenvs/py3neovim/bin/python3'

vim.opt.title = true
vim.opt.titlestring = "%t %y"
vim.opt.autoread = true
vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.encoding = "utf-8"
vim.opt.cursorline = true

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- LIneabraks with indentation
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = ".."

-- Change buffer without saving
vim.opt.hidden = true

-- Use spaces to replace tabs
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Allow virtual editing in visual block
vim.opt.virtualedit = "block"

-- Ignore certain files
vim.opt.wildignore = { "*.swp", "*.bak", "*.pyc", "*.class", "*.aux", "*.toc" }

-- Always show status bar
vim.opt.laststatus = 2

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.diffopt:append("vertical")

vim.opt.shada:append('r/mnt/intcdc')

vim.g.mapleader = "\\"

-- Visual selection copies to the clipboard
vim.opt.clipboard:append('unnamedplus')

vim.g.completion_sorting = "none"
