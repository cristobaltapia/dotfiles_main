-- Set error format
vim.cmd([[set errorformat=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#]])
vim.cmd([[set errorformat+=%C\ %#%m,%Z%[%^\ ]%\\@=%m]])
vim.cmd([[set errorformat+=%W%f:%l:\ %m,%Z\ \ %m,%Z%m]])

-- Configure jupyter integration

local group_jupyter = vim.api.nvim_create_augroup("jupyter-ascending", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.sync.py" },
    callback = function()
        vim.opt_local.filetype = 'syncpy'
        -- Define new key bindings
        vim.keymap.set("n", "<leader><leader>x", "<Plug>JupyterExecute")
        vim.keymap.set("n", "<leader><leader>X", "<Plug>JupyterExecuteAll")
        vim.keymap.set("n", "<leader><leader>r", "<Plug>JupyterRestart")
        -- Delete default key bindings
        vim.keymap.del("n", "<space><space>x")
        vim.keymap.del("n", "<space><space>X")
        vim.keymap.del("n", "<space><space>r")

        vim.opt_local.syntax = 'python'
        vim.opt_local.filetype = 'python'
    end
})
