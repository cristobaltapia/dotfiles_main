local cpo_save = vim.opt.cpoptions
vim.opt.cpoptions:remove("C")

-- Set error format
vim.cmd([[set errorformat=
\%E\ \ File\ \"%f\"\\\,\ line\ %l\\\,\ in\ %o%\\C,
\%E\ \ File\ \"%f\"\\\,\ line\ %l%\\C,
\%W%f:%l:\ %.%#%tarning%m,
\%+Z%.%#%trror:\ %.%#,
\%C%p^,
\%-C\ \ \ \ %.%#,
\%-C\ \ %.%#,
\%-Z,
\%-Z\ \ %.%#,
\%+C%.%#,
\%-G\ \ %.%#,
\%-G%.%#
]]
)

vim.opt.makeprg = "python"

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "quickfix",
    callback = function()
        vim.opt_local.wrap = true
    end
})
