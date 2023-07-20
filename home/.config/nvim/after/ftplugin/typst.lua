vim.keymap.set("n", "<F5>", ":AsyncRun! -cwd=$(VIM_FILEDIR) -save=1 -mode=hide -raw -pos=bottom -rows=15 -focus=0 typst compile '$(VIM_FILEPATH)'<CR><CR>")
