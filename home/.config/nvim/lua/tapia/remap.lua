vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allow to move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Keep search items in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without deleting the previous selection
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Yank to system clipboard
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

-- Replace word below the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Correct spelling in insert mode
vim.keymap.set("i", "<C-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

-- Faster folding
vim.keymap.set({ "n", "v" }, "<space>", "za")

-- Mas <Esc> to shift-space
vim.keymap.set({ "i", "v", "s" }, "<S-Space>", "<Esc>")
vim.keymap.set({ "i", "v", "s" }, "<M-Space>", "<Esc>")

-- Redefine movements
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

-- For the quickfix window it is better to undo the previous remapping
local qf_group = vim.api.nvim_create_augroup('quickfix', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'qf' },
    group = qf_group,
    callback = function()
        vim.keymap.set('n', 'j', 'j', { buffer = true })
        vim.keymap.set('n', 'k', 'k', { buffer = true })
    end,
})

-- Move to next buffer
vim.keymap.set("n", "tn", "<cmd>bnext<cr>")
vim.keymap.set("n", "tp", "<cmd>bprevious<cr>")

-- Close current buffer
vim.keymap.set("n", "<leader>bq", "<cmd>bp <BAR> bd #<cr>")

-- Close quickfix window
vim.keymap.set("n", "<leader>cq", vim.cmd.cclose)

-- Run files with overseer
local overseer = require("overseer")
local function compile_and_run()
    local file_path = vim.api.nvim_buf_get_name(0)
    local file_cwd = vim.loop.cwd()

    if vim.bo.filetype == 'python' then
        vim.cmd("write")
        overseer.run_template({ name = "python_build" })
    end
end

vim.keymap.set('n', '<F5>', compile_and_run)
