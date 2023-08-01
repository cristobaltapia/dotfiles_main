local cpo_save = vim.opt.cpoptions
vim.opt.cpoptions:remove("C")

-- Set error format
vim.cmd([[set errorformat=
\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
\%C\ \ \ \ %.%#,
\%+Z%.%#Error\:\ %.%#,
\%A\ \ File\ \"%f\"\\\,\ line\ %l,
\%+C\ \ %.%#,
\%-C%p^,
\%Z%m,
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
