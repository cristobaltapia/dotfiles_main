vim.g.tmux_navigator_no_mappings = true

vim.keymap.set("n", "<A-h>", vim.cmd.TmuxNavigateLeft, {silent = true})
vim.keymap.set("n", "<A-j>", vim.cmd.TmuxNavigateDown, {silent = true})
vim.keymap.set("n", "<A-k>", vim.cmd.TmuxNavigateUp, {silent = true})
vim.keymap.set("n", "<A-l>", vim.cmd.TmuxNavigateRight, {silent = true})
vim.keymap.set("n", "<A-\\>", vim.cmd.TmuxNavigatePrevious, {silent = true})
