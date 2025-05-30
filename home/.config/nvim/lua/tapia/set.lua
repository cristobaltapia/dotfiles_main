vim.g.python3_host_prog = vim.env.HOME .. "/.virtualenvs/py3neovim/bin/python3"

vim.opt.title = true
vim.opt.titlestring = "%t %y"
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.encoding = "utf-8"
vim.opt.cursorline = true

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Lineabraks with indentation
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "󱞩 "
vim.opt.wrap = true

-- Change buffer without saving
vim.opt.hidden = true

-- Atomatically change current working directory to the directory
-- containing the file in the buffer
vim.opt.autochdir = true

-- Use spaces to replace tabs
vim.opt.expandtab = true

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
vim.opt.diffopt:append("linematch:60")

vim.opt.shada:append("r/mnt/intcdc")

-- Visual selection copies to the clipboard
vim.opt.clipboard:append("unnamedplus")

vim.g.completion_sorting = "none"
vim.g.completeopt = "menu,menuone,noinsert"

-- Size of the completion menu
vim.opt.pumheight = 15

-- Set python syntax for Freecad macros
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.fcmacro" },
  callback = function()
    vim.opt.filetype = "python"
  end,
})
-- Set tex syntax for pdf_tex files
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.pdf_tex" },
  callback = function()
    vim.opt.filetype = "tex"
  end,
})

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Disable editorconfig
vim.g.editorconfig = false

-- Set default tabsize
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Make history persistent between sessions
vim.opt.undofile = true
vim.opt.undodir = vim.env.HOME .. "/.config/nvim/undodir"

if not vim.fn.isdirectory(vim.env.HOME .. "/.config/nvim/undodir") then
  vim.fn.mkdir(vim.env.HOME .. "/.config/nvim/undodir")
end

vim.opt.laststatus = 3

vim.o.winborder = "rounded"

-- Increase update frequency of the ui
vim.opt.updatetime = 500
