return {
  -- Fugitive
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function(_, opts)
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')
          vim.keymap.set("n", "<leader>gn",
            function()
              gitsigns.next_hunk({ foldopen = true })
            end
          )
          vim.keymap.set("n", "<leader>gN",
            function()
              gitsigns.prev_hunk({ foldopen = true })
            end
          )
          vim.keymap.set("n", "<leader>gp",
            gitsigns.preview_hunk
          )
        end
      }
      vim.api.nvim_set_hl(0, 'GitSignsAddLn', { fg = "#434c5e", bg = "#a3be8c" })
    end
  },
}
-- vim: set shiftwidth=2:
