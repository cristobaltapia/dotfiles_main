return {
  {
    'kaarmu/typst.vim',
    ft = { "typst" },
    branch = 'main',
    dependencies = { {'skywind3000/asyncrun.vim'} },
    config = function ()
      vim.keymap.set("n", "<leader>lv", "<cmd>AsyncRun -mode=hide zathura '%<'.pdf <cr>")
    end
  },
}
-- vim: set shiftwidth=2:
