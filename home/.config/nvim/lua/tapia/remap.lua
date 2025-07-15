vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Delete default LSP keymap
vim.keymap.del("i", "<C-S>")

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

-- Map <Esc> to shift-space
vim.keymap.set({ "i", "v", "s" }, "<S-Space>", "<Esc>")
vim.keymap.set({ "i", "v", "s" }, "<M-Space>", "<Esc>")
vim.keymap.set({ "i", "v", "s" }, "<c-e>", "<Esc>")

-- Redefine movements
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

vim.keymap.set("n", "<Up>", "g<Up>")
vim.keymap.set("n", "<Down>", "g<Down>")
vim.keymap.set("n", "g<Up>", "<Up>")
vim.keymap.set("n", "g<Down>", "<Down>")

-- Escape to normal mode when in terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- For the quickfix window it is better to undo the previous remapping
local qf_group = vim.api.nvim_create_augroup("quickfix", { clear = true })

-- Store the global scrolloff value
local global_scrolloff = vim.o.scrolloff

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "qf" },
  group = qf_group,
  callback = function()
    vim.keymap.set("n", "j", "j", { buffer = true })
    vim.keymap.set("n", "k", "k", { buffer = true })
    vim.keymap.set("n", "<Up>", "<Up>", { buffer = true })
    vim.keymap.set("n", "<Down>", "<Down>", { buffer = true })
    vim.wo.scrolloff = 0
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = { "qf" },
  group = qf_group,
  callback = function()
    vim.wo.scrolloff = global_scrolloff
  end,
})

-- Move to next buffer
vim.keymap.set("n", "tn", "<cmd>bnext<cr>")
vim.keymap.set("n", "tp", "<cmd>bprevious<cr>")

-- Close current buffer
vim.keymap.set("n", "<leader>bq", "<cmd>bp <BAR> bd #<cr>")

-- Close quickfix window
vim.keymap.set("n", "<leader>cq", vim.cmd.cclose)

-- Toggle inlay hints
vim.keymap.set("n", "<leader>hh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Define mapping for triggering blink.cmp completion. For some reason,
-- defining this function inside the configuration of blink.cmp gives errors
-- when the UltiSnips#ExpandSnippet() function is called.
vim.keymap.set("i", "<C-space>",
  function()
    local blink = require("blink-cmp")
    -- if blink.is_visible() then
    if blink.is_menu_visible() then
      -- Insert text if the selection is a path and replace otherwise.
      blink.select_and_accept()
    else
      vim.cmd("call UltiSnips#ExpandSnippet()")
    end
  end
)

-- The following keymaps are activated on lsp attach
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    -- Define current bufnr
    local bufnr = event.buf
    local map = function(m, lhs, rhs)
      local options = { buffer = bufnr, remap = false }
      vim.keymap.set(m, lhs, rhs, options)
    end

    -- LSP actions
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gD", vim.lsp.buf.declaration)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "go", vim.lsp.buf.type_definition)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "gs", vim.lsp.buf.signature_help)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    -- Formatting is done with conform.nvim
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("x", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

    -- Diagnostics
    map("n", "ge", vim.diagnostic.open_float)

    -- Set folding method
    vim.o.foldmethod = "expr"
  end,
})
