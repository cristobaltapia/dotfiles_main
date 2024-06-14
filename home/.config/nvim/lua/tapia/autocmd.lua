-- Define some useful autocommands

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.opt.expandtab = true
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
  end,
})

local asyncrun_group = vim.api.nvim_create_augroup("asyncrun", { clear = true })

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AsyncRunStart" },
  group = asyncrun_group,
  command = "call asyncrun#quickfix_toggle(10, 1)",
})
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AsyncRunStop" },
  group = asyncrun_group,
  command = "copen | clast | wincmd k",
})
