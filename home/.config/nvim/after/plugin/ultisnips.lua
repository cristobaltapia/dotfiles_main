--[[ vim.g.UltiSnipsExpandTrigger = "<c-k>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>" ]]

vim.g.UltiSnipsSnippetDirectories = {
    'UltiSnips',
    vim.env.HOME .. '/.vim/plugged/MySnippets/Ultisnips',
    vim.env.HOME .. '/Templates/ultisnips-templates'
}

-- Set the smart function definition to use numpy style for docstrings
vim.g.ultisnips_python_style = "numpy"
vim.g.UltisnipsUsePythonVersion = 3

