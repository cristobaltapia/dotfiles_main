vim.opt_local.textwidth = 80
vim.opt_local.formatoptions = "cqj"

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autochdir = false

--- Get class and method under the cursor
--- This is used to get the information needed to run only the test under the
--- cursor with pytest.
local function get_class_and_method_ts()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Get file name
  local fname = vim.fn.fnameescape(vim.fn.expand("%"))

  -- Get the treesitter parser for this buffer
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "python")
  if not ok or not parser then
    vim.notify("No treesitter parser found for python", vim.log.levels.WARN)
    return nil
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  -- Get cursor position (0-indexed row for treesitter)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  -- Find the smallest node at the cursor position
  local node = root:named_descendant_for_range(row, col, row, col)
  if not node then
    return nil
  end

  local function_name, class_name = nil, nil

  -- Walk up the tree collecting the nearest enclosing function/class defs
  local current = node
  while current ~= nil do
    local type = current:type()

    if type == "function_definition" and not function_name then
      local name_node = current:field("name")[1]
      if name_node then
        function_name = vim.treesitter.get_node_text(name_node, bufnr)
      end
    elseif type == "class_definition" and not class_name then
      local name_node = current:field("name")[1]
      if name_node then
        class_name = vim.treesitter.get_node_text(name_node, bufnr)
      end
    end

    -- Stop once we've found both
    if function_name and class_name then
      break
    end

    current = current:parent()
  end

  if class_name and function_name then
    return fname .. "::" .. class_name .. "::" .. function_name
  elseif function_name then
    return fname .. "::" .. function_name
  elseif class_name then
    return fname .. "::" .. class_name
  else
    return nil
  end
end

-- Configuration of debugger with dap
local util = require("lspconfig.util")
local dap_ok, _ = pcall(require, "dap")
if dap_ok then
  local dap = require("dap")

  -- Visual debugging for build123d using ocp_vscode
  dap.listeners.after.event_stopped["build123d-debug"] = function(session, body)
    if session.config.name == "build123d (visual debug)" then
      session:evaluate(
        "from ocp_vscode import show_all, get_port, Camera; show_all(locals(), port=get_port(), _visual_debug=True, reset_camera=Camera.KEEP)",
        function(err, response)
          if err then
            print("Evaluation error: " .. vim.inspect(err))
          end
        end,
        { context = "repl" }
      )
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
      args = { "${file}" },
      redirectOutput = true,
      pythonPath = get_python_path,
    },
    {
      -- Set configuration to run pytest
      type = "python",
      request = "launch",
      name = "Pytest (method under cursor)",
      module = "pytest",
      args = { get_class_and_method_ts },
      redirectOutput = true,
      pythonPath = get_python_path,
    },
    {
      -- Set configuration to run AppDaemon
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
