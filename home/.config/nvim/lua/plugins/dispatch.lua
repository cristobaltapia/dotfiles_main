return {
  {
    "tpope/vim-dispatch",
    ft = { "typst", "python", "fortran", "make", "rust" },
    keys = { "<F4>", "<F5>", "<F7>" },
    config = function()
      local Path = require("plenary.path")
      -- Execute programs asyncronously
      local function save_and_run_async()
        -- Save file
        vim.cmd.write()
        -- Get filetype
        local ft = vim.bo.filetype
        local ext = vim.fn.expand("%:e")
        -- Execute command according to filetype
        local dir = vim.fn.fnameescape(vim.fn.expand("%:p:h"))
        local filename = vim.fn.fnameescape(vim.fn.expand("%:p"))

        if ft == "typst" then
          vim.cmd("Dispatch! -compiler=typst -dir=" .. dir .. " typst watch " .. filename)
        elseif ft == "fortran" then
          vim.cmd("Dispatch -compiler=abaqus -dir=" .. dir .. " abq2022 make library=" .. filename)
        elseif ext == "fcmacro" then
          vim.cmd("Dispatch -compiler=python -dir=" .. dir .. " freecadcmd " .. filename)
        elseif ft == "python" then
          -- For python always check if we are inside a project and use the root folder
          -- as dir
          local util = require("lspconfig.util")
          local root_dir = util.root_pattern("pyproject.toml")(vim.fn.getcwd()) or dir
          -- Also use the local virtual environment if present
          local pyexe
          if vim.fn.executable(root_dir .. "/.venv/bin/python") == 1 then
            pyexe = root_dir .. "/.venv/bin/python"
          else
            pyexe = "python"
          end
          vim.cmd("Dispatch -compiler=python -dir=" .. root_dir .. " " .. pyexe .. " " .. filename)
          vim.cmd("Copen")
        end
      end

      local function pytest_async()
        -- Save file
        vim.cmd.write()
        -- Get filetype
        local ft = vim.bo.filetype
        -- Execute command according to filetype

        if ft == "python" then
          vim.cmd("Dispatch -compiler=pytest pytest --tb=short -q")
        end
      end

      vim.keymap.set("n", "<F4>", pytest_async)
      vim.keymap.set("n", "<F5>", save_and_run_async)
      vim.keymap.set("n", "<F7>", function() vim.cmd('AbortDispatch') end)
      -- Deactivate default mappings
      vim.g.dispatch_no_maps = 1
      vim.g.dispatch_no_tmux_start = 1
      vim.g.dispatch_no_tmux_make = 1
    end,
  },
}
