return {
  {
    "tpope/vim-dispatch",
    ft = { "typst", "python" },
    keys = { "<F5>" },
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

        print(filename)
        if ft == "typst" then
          vim.cmd('Dispatch -compiler=typst -dir=' .. dir .. ' typst compile ' .. filename)
        elseif ft == "python" then
          vim.cmd('Dispatch -compiler=python -dir=' .. dir .. ' python ' .. filename)
        end
      end
      vim.keymap.set("n", "<F5>", save_and_run_async)
      -- Deactivate default mappings
      vim.g.dispatch_no_maps = 1
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
