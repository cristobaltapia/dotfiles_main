-- Set error format
vim.cmd([[set errorformat=%Eerror:\ %m]])
vim.cmd([[set errorformat+=%Ihelp:\ %m]])
vim.cmd([[set errorformat+=%C\ \ ┌─\ /%f:%l:%c]])
vim.cmd([[set errorformat+=%C\ \ \ ┌─\ /%f:%l:%c]])
vim.cmd([[set errorformat+=%C%s]])
vim.cmd([[set errorformat+=%Z]])
