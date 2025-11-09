vim.opt_local.textwidth = 80
vim.opt_local.formatoptions = "cqj"

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autochdir = false

-- Configuration of debugger with dap
local util = require("lspconfig.util")
local dap_ok, _ = pcall(require, "dap")
if dap_ok then
  local dap = require("dap")

  -- Visual debugging for build123d using ocp_vscode
  dap.listeners.after.event_stopped["auto-print-test"] = function(session, body)
    if session.config.name == "build123d (visual debug)" then
      session:evaluate('from ocp_vscode import show_all, get_port; show_all(locals(), port=get_port(), _visual_debug=True)', function(err, response)
        if err then
          print("Evaluation error: " .. vim.inspect(err))
        end
      end, { context = "repl" })
    end
  end

  dap.adapters.python = function(cb, config)
    if config.request == "attach" then
      local port = (config.connect or config).port
      local host = (config.connect or config).host or "127.0.0.1"
      cb({
        type = "server",
        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
        host = host,
        options = {
          source_filetype = "python",
        },
      })
    else
      cb({
        type = "executable",
        command = vim.env.HOME .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
        options = {
          source_filetype = "python",
        },
      })
    end
  end

  local function get_python_path()
    local dir = vim.fn.fnameescape(vim.fn.expand("%:p:h"))
    local cwd = util.root_pattern("pyproject.toml")(vim.fn.getcwd()) or dir
    if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
      return cwd .. "/.venv/bin/python"
    else
      return "python"
    end
  end

  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      redirectOutput = true,
      cwd = function()
        local cwd = util.root_pattern("pyproject.toml")(vim.fn.getcwd())
        if cwd then
          return util.root_pattern("pyproject.toml")(vim.fn.getcwd())
        else
          return "."
        end
      end,
      pythonPath = get_python_path,
    },
    {
      -- The first three options are required by nvim-dap
      type = "python",
      request = "launch",
      name = "build123d (visual debug)",
      program = "${file}",
      redirectOutput = true,
      cwd = function()
        local cwd = util.root_pattern("pyproject.toml")(vim.fn.getcwd())
        if cwd then
          return util.root_pattern("pyproject.toml")(vim.fn.getcwd())
        else
          return "."
        end
      end,
      pythonPath = get_python_path,
    },
    {
      -- Set configuration to debug a django project
      type = "python",
      request = "launch",
      name = "Django server",
      program = function()
        return util.root_pattern("manage.py")(vim.fn.getcwd()) .. "/manage.py"
      end,
      args = { "runserver" },
      redirectOutput = true,
      pythonPath = get_python_path,
    },
    {
      -- Set configuration to run pytest
      type = "python",
      request = "launch",
      name = "Pytest (all)",
      module = "pytest",
      args = { "--color=yes", "tests" },
      redirectOutput = true,
      pythonPath = get_python_path,
    },
    {
      -- Set configuration to run pytest
      type = "python",
      request = "launch",
      name = "Pytest (current file)",
      module = "pytest",
      args = { "--color=yes", "${file}" },
      redirectOutput = true,
      pythonPath = get_python_path,
    },
    {
      -- Set configuration to run pytest
      type = "python",
      request = "launch",
      name = "AppDaemon",
      redirectOutput = true,
      module = "appdaemon",
      args = { "-c", "config" },
      cwd = function()
        return util.root_pattern("pyproject.toml")(vim.fn.getcwd())
      end,
      pythonPath = get_python_path,
    },
  }
end
