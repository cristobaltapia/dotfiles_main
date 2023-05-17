require("lsp_signature").setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hind_enable = true,
    doc_lines = 0,
    floating_window_above_cur_line = true,
    handler_opts = {
        border = "rounded"
    }
})
