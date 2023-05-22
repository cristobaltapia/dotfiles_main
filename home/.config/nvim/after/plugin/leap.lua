vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
vim.keymap.set('n', 's', '<Plug>(leap-forward-to)', { silent = true })
vim.keymap.set('n', 'S', '<Plug>(leap-backward-to)', { silent = true })
