return {
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
