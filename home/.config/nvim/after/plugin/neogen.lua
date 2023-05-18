local neogen = require("neogen")
neogen.setup {
    enabled = true,
    input_after_comment = true,
    languages = {
        python = {
            template = {
                annotation_convention = 'numpydoc',
            }
        }
    }
}

-- Define keybindings
vim.keymap.set({"n"}, "<leader>ds", neogen.generate)
