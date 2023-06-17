return {
    name = "python_build",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        return {
            cmd = { "python" },
            args = { file },
            components = {
                { "on_exit_set_status" },
                {
                    "display_duration",
                    detail_level = 2,
                },
                {
                    "on_output_quickfix",
                    open = true,
                    items_only = false,
                    tail = true,
                },
            },
        }
    end,
    condition = {
        filetype = { "python" },
    },
}
