return {
  {
    'skywind3000/asyncrun.vim',
    ft = { 'python', 'typst' },
    keys = { "<F5>" },
    config = function()
      -- Execute programs asyncronously
      local function run_async()
        local ft = vim.bo.filetype
        if ft == "typst" then
          vim.cmd('AsyncRun! -cwd=$(VIM_FILEDIR) -save=1 -pos=bottom -rows=15 -focus=0 typst compile "$(VIM_FILEPATH)"')
        elseif ft == "python" then
          vim.cmd('AsyncRun! -cwd=$(VIM_FILEDIR) -save=1 -pos=bottom -rows=15 -focus=0 python "$(VIM_FILEPATH)"')
        end
      end

      vim.keymap.set("n", "<F5>", run_async)
    end
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
