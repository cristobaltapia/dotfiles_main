return {
    {
        "mfussenegger/nvim-dap",
        ft = {"python"},
        keys = {
            { "<F8>",
                function()
                    require('dap').toggle_breakpoint()
                end
            },
            { "<F6>",
                function()
                    require('dap').continue()
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
                    require('dap').disconnect()
                    require('dap').terminate()
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

            local Path = require('plenary.path')
            -- Find 'manage.py' for django projects
            local function find_manage_py_folder(start_path)
                local function search_manage_py(path, levels)
                    if levels == 0 then
                        return ""
                    end

                    -- Get all folders and files in 'path'
                    local cwdContent = vim.split(vim.fn.glob(path .. "/*"), '\n', { trimempty = true })
                    for _, entry in pairs(cwdContent) do
                        -- Create new Path object
                        local new_path = Path:new(entry)
                        if new_path:is_dir() then
                            local manage_py_path = new_path:joinpath('manage.py')
                            if manage_py_path:exists() then
                                return new_path
                            else
                                local subfolder_result = search_manage_py(new_path, levels - 1)
                                if subfolder_result then
                                    return subfolder_result
                                end
                            end
                        end
                    end
                    return nil
                end
                local start_dir = Path:new(start_path)
                if start_dir:exists() and start_dir:is_dir() then
                    -- Maximum search depth is set to 1
                    return search_manage_py(start_dir, 1)
                else
                    return nil
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
                {
                    -- Set configuration to debug a django project
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "Django server",
                    program = find_manage_py_folder(vim.fn.getcwd()) .. "/manage.py",
                    args = { "runserver" },
                    redirectOutput = true,
                    pythonPath = 'python',
                },
            }

            -- Autocompletion for the REPL
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

            -- Define listeners for opening and closing the REPL
            dap.listeners.before.attach.python = function()
                dap.repl.open()
            end
            dap.listeners.before.launch.python = function()
                dap.repl.open()
            end
            dap.listeners.after.disconnect.python = function()
                dap.repl.close()
            end
            dap.listeners.after.terminate.python = function()
                dap.repl.close()
            end
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
