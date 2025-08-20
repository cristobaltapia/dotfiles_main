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

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  desc = "Reload folding every time insert mode is left.",
  command = "set foldmethod=expr",
})

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
--   group = vim.api.nvim_create_augroup("ScrollOffEOF", {}),
--   callback = function()
--     local win_h = vim.api.nvim_win_get_height(0)
--     local off = vim.o.scrolloff
--     local dist = vim.fn.line("$") - vim.fn.line(".")
--     local rem = vim.fn.line("w$") - vim.fn.line("w0") + 1
--     if dist < off and win_h - rem + dist < off then
--       local view = vim.fn.winsaveview()
--       view.topline = view.topline + off - (win_h - rem + dist)
--       vim.fn.winrestview(view)
--     end
--   end,
-- })
