return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    cmd = "Telescope",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "live grep",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "find buffers",
      },
      {
        "<C-p>",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "find git files",
      },
      {
        "<leader>ps",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end,
        desc = "Grep",
      },
    },
    opts = {
      defaults = {
        scroll_strategy = "limit",
        winblend = 30,
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.85,
            height = 0.95,
            preview_cutoff = 10,
            mirror = false,
          },
          center = {
            width = 0.85,
            height = 0.95,
            preview_cutoff = 10,
            prompt_position = "top",
          },
        },
        file_ignore_patterns = {
          "%.pyc",
          "%.rpy",
          "%.fil",
        },
      },
      pickers = {
        find_files = {
          follow = true,
        },
      },
    },
  },
}
-- vim: set shiftwidth=2:
