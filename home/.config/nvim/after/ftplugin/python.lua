-- Set error format
vim.cmd([[set errorformat=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#]])
vim.cmd([[set errorformat+=%C\ %#%m,%Z%[%^\ ]%\\@=%m]])
vim.cmd([[set errorformat+=%W%f:%l:\ %m,%Z\ \ %m,%Z%m]])
