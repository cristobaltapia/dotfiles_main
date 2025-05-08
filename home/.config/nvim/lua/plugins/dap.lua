return {
  {
    "mfussenegger/nvim-dap",
    ft = { "python" },
    keys = {
      {
        "<F8>",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<F6>",
        function()
          require("dap").continue()
        end,
      },
      {
        "<leader>es",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
      },
      {
        "<leader>dq",
        function()
          require("dap").repl.close()
          require("dap").terminate()
        end,
      },
      {
        "<leader>dd",
        function()
          require("dap").disconnect()
          require("dap").terminate()
        end,
      },
    },

    config = function(_, opts)
      local dap = require("dap")
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Debug", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "ErrorMsg", linehl = "", numhl = "" })

      --
      -- INFO:
      -- The configurations for each filetype are defined in the respective after/ftplugin subdir.
      --

      -- Define listeners for opening and closing the REPL
      local fts = { "python", "rust" }
      for _, ft in pairs(fts) do
        dap.listeners.before.attach[ft] = function()
          dap.repl.open()
        end
        dap.listeners.before.launch[ft] = function()
          dap.repl.open()
        end
        dap.listeners.after.disconnect[ft] = function()
          dap.repl.close()
        end
        dap.listeners.after.terminate[ft] = function()
          dap.repl.close()
        end
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
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
            disconnect = "⏻",
          },
        },
      }

      local dapui = require("dapui")
      dapui.setup(ui_config)
    end,
  },
}
-- vim: set shiftwidth=2:
