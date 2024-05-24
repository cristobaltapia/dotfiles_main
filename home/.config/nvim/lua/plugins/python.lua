return {
  {
    "tpope/vim-dispatch",
    ft = { "typst", "python", "fortran", "make" },
    keys = { "<F4>", "<F5>" },
    config = function()
      -- Execute programs asyncronously
      local function save_and_run_async()
        -- Save file
        vim.cmd.write()
        -- Get filetype
        local ft = vim.bo.filetype
        -- Execute command according to filetype
        local dir = vim.fn.fnameescape(vim.fn.expand("%:p:h"))
        local filename = vim.fn.fnameescape(vim.fn.expand("%:p"))

        if ft == "typst" then
          vim.cmd('Dispatch -compiler=typst -dir=' .. dir .. ' typst compile ' .. filename)
        elseif ft == "fortran" then
          vim.cmd('Dispatch -compiler=abaqus -dir=' .. dir .. ' abq2022 make library=' .. filename)
        elseif ft == "python" then
          vim.cmd('Dispatch -compiler=python -dir=' .. dir .. ' python ' .. filename)
        end
      end

      local function pytest_async()
        -- Save file
        vim.cmd.write()
        -- Get filetype
        local ft = vim.bo.filetype
        -- Execute command according to filetype

        if ft == "python" then
          vim.cmd('Dispatch -compiler=pytest pytest --tb=short -q')
        end
      end

      vim.keymap.set("n", "<F4>", pytest_async)
      vim.keymap.set("n", "<F5>", save_and_run_async)
      -- Deactivate default mappings
      vim.g.dispatch_no_maps = 1
      vim.g.dispatch_no_tmux_start = 1
      vim.g.dispatch_no_tmux_make = 1
    end,
  },
  {
    'untitled-ai/jupyter_ascending.vim',
    event = "BufEnter *.sync.py",
    dependencies = {
      { 'kana/vim-textobj-user' },
      { 'GCBallesteros/vim-textobj-hydrogen' },
    },
    keys = {
      { "<leader><leader>x", "<Plug>JupyterExecute" },
      { "<leader><leader>X", "<Plug>JupyterExecuteAll" },
      { "<leader><leader>r", "<Plug>JupyterRestart" },
    },
    config = function()
      -- Delete default key bindings
      vim.keymap.del("n", "<space><space>x")
      vim.keymap.del("n", "<space><space>X")
      vim.keymap.del("n", "<space><space>r")
    end
  },
  -- {
  --   'stevearc/overseer.nvim',
  --   opts = {
  --     templates = { "builtin", "user.python_build" }
  --   },
  -- }
}
-- vim: set shiftwidth=2:
