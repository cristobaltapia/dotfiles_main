require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set("n", "<leader>gn",
            function()
                gitsigns.next_hunk({ foldopen = true })
            end
        )
        vim.keymap.set("n", "<leader>gN",
            function()
                gitsigns.prev_hunk({ foldopen = true })
            end
        )
        vim.keymap.set("n", "<leader>gp",
            gitsigns.preview_hunk
        )
    end
}
