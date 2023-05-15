local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

local telescope = require('telescope')

telescope.setup {
    defaults = {
        scroll_strategy = "limit",
        winblend = 30,
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
            vertical = {
                width = 0.85,
                height = 0.95,
                preview_cutoff = 10,
                mirror = false,
            },
            center = {
                width = 0.85,
                height = 0.95,
                preview_cutoff = 10,
                prompt_position = 'top',
            },
        },
        file_ignore_patterns = {
            "%.pyc",
            "%.rpy",
            "%.fil",
        }
    },
}
