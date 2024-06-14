return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- { "nvim-treesitter/nvim-treesitter" }
    },
    ft = { "python", "lua" },
    keys = {
      {
        "<leader>re",
        "<cmd>Refactor extract<cr>",
        mode = "v",
        { noremap = true, silent = true, expr = false },
      },
      {
        "<leader>rf",
        "<cmd>Refactor extract_to_file<cr>",
        mode = "v",
        { noremap = true, silent = true, expr = false },
      },
      {
        "<leader>rv",
        "<cmd>Refactor extract_var<cr>",
        mode = "v",
        { noremap = true, silent = true, expr = false },
      },
      {
        "<leader>ri",
        "<cmd>Refactor inline_var<cr>",
        mode = "v",
        { noremap = true, silent = true, expr = false },
      },
    },
    config = function()
      require("refactoring").setup({})
    end,
  },
}
-- vim: set shiftwidth=2:
