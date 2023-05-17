vim.g.UltiSnipsSnippetDirectories = {
    'UltiSnips',
    vim.env.HOME .. '/.local/share/nvim/lazy/MySnippets/Ultisnips',
    vim.env.HOME .. '/Templates/ultisnips-templates'
}

-- Set the smart function definition to use numpy style for docstrings
vim.g.ultisnips_python_style = "numpy"
vim.g.UltisnipsUsePythonVersion = 3
