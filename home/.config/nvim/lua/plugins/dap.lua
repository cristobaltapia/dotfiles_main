return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<F8>",
                function()
                    require('dap').toggle_breakpoint()
                end
            },
            { "<F6>",
                function()
                    require('dap').continue()
                    require('dap').repl.open()
                end
            },
            { "<leader>es",
                function()
                    require('dap').step_into()
                end
            },
            { "<leader>dr",
                function()
                    require('dap').repl.toggle()
                end
            },
            { "<leader>dq",
                function()
                    require('dap').repl.close()
                end
            },
            { "<leader>dd",
                function()
                    require('dap').close()
                end
            },
        },
        config = function(_, opts)
            local dap = require('dap')

            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                    local port = (config.connect or config).port
                    local host = (config.connect or config).host or '127.0.0.1'
                    cb({
                        type = 'server',
                        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                        host = host,
                        options = {
                            source_filetype = 'python',
                        },
                    })
                else
                    cb({
                        type = 'executable',
                        command = vim.env.HOME .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
                        args = { '-m', 'debugpy.adapter' },
                        options = {
                            source_filetype = 'python',
                        },
                    })
                end
            end

            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}", -- This configuration will launch the current file if used.
                    redirectOutput = true,
                    pythonPath = function()
                        -- debugpy supports launching an application with a different interpreter than the one used to launch debugpy itself.
                        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return 'python'
                        end
                    end,
                },
            }

            require("cmp").setup({
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end
            })

            require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })
        end

    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function(_, opts)
            -- Configure icons
            local ui_config = {
                icons = { expanded = "🞃", collapsed = "🞂", current_frame = "→" },
                controls = {
                    icons = {
                        pause = "⏸",
                        play = "⯈",
                        step_into = "↴",
                        step_over = "↷",
                        step_out = "↑",
                        step_back = "↶",
                        run_last = "🗘",
                        terminate = "🕱",
                        disconnect = "⏻"
                    }
                }
            }

            local dapui = require("dapui")
            dapui.setup(ui_config)
        end
    }
}
