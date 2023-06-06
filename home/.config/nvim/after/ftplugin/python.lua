-- Set error format
vim.cmd([[set errorformat=%A\ \ File\ \"%f\"\\,\ line\ %l\\,\ in\ %o]])
vim.cmd([[set errorformat+=%-C\ \ \ \ %.%#]])
vim.cmd([[set errorformat+=%C%m,%Z%[%^\ ]%\\@=%m]])
vim.cmd([[set errorformat+=%W%f:%l:\ %m,%Z\ \ %m,%Z%m]])
-- vim.cmd([[set errorformat+=%-G||]])
vim.opt_local.textwidth = 80
vim.opt_local.formatoptions = "cqj"
