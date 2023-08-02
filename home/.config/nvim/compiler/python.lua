local cpo_save = vim.opt.cpoptions
vim.opt.cpoptions:remove("C")

-- Set error format
vim.cmd([[set errorformat=
\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,\ in\ %o%\\C,
\%A\ \ File\ \"%f\"\\\,\ line\ %l%\\C,
\%W%f:%l:\ %m,
\%C%p^,
\%-C\ \ \ \ %.%#,
\%-C\ \ %.%#,
\%+C%.%#,
\%Z%\\S%\\&%m,
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
