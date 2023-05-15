vim.g.gitgutter_max_signs = 500

vim.keymap.set("n", "<Leader>dc" ,vim.cmd.GitGutterPreviewHunk)
vim.keymap.set("n", "<Leader>gs" ,vim.cmd.GitGutterStageHunk)
vim.keymap.set("n", "<Leader>gn" ,vim.cmd.GitGutterNextHunk)
