-- Configuration of debugger with dap
local util = require("lspconfig.util")
local dap_ok, _ = pcall(require, "dap")

local debugger_script = [[
using Pkg
Pkg.instantiate()

using Sockets
using DebugAdapter
using Logging

function start_debugger()
    server_port = parse(Int, ARGS[1])

    server = Sockets.listen(server_port)

    conn = Sockets.accept(server)
    debugsession = DebugAdapter.DebugSession(conn)

    run(debugsession)

    close(conn)
end

start_debugger()
]]

if dap_ok then
  local dap = require("dap")

  dap.adapters.julia = {
    type = "server",
    port = "${port}",
    executable = {
      command = "julia",
      args = { "--project=" .. util.root_pattern("Project.toml")(vim.fn.getcwd()), "-e", debugger_script, "${port}" },
    },
    options = {
      max_retries = 100,
    },
  }

  dap.configurations.julia = {
    {
      type = "julia",
      name = "Debug julia executable",
      request = "launch",
      program = "${file}",
      projectDir = "${workspaceFolder}",
      juliaEnv = "${workspaceFolder}",
      exitAfterTaskReturns = false,
      debugAutoInterpretAllModules = false,
      redirectOutput = true,
      stopOnEntry = true,
      args = {},
    },
  }
end
