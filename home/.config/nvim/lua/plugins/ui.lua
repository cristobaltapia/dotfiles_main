return {
  -- Colorschemes
  {
    'shaunsingh/nord.nvim',
    name = 'nord',
    config = function()
      vim.cmd('colorscheme nord')
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ebcb8b", bold = true })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#434c5e" })
    end
  },
  -- Tmux
  {
    'jpalardy/vim-slime',
    keys = {
      { "<C-c><C-c>", mode = "n" },
      { "<C-c><C-c>", mode = "v" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "0.1" }
      vim.g.slime_bracketed_paste = 1
    end
  },
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      extensions = { 'quickfix', 'fugitive' },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_z = { function()
          return [[buffers]]
        end },
      },
    },
  },
  -- FZF support
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf', build = './install --all' },
    },
  },
  -- Integration with tmux
  {
    'christoomey/vim-tmux-navigator',
    lazy = true,
    keys = {
      { "<A-h>", "<cmd>TmuxNavigateLeft<cr>",  "n", { silent = true } },
      { "<A-j>", "<cmd>TmuxNavigateDown<cr>",  "n", { silent = true } },
      { "<A-k>", "<cmd>TmuxNavigateUp<cr>",    "n", { silent = true } },
      { "<A-l>", "<cmd>TmuxNavigateRight<cr>", "n", { silent = true } },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = true
    end
  },
  -- Nice visualization of quickfix errors
  { 'kevinhwang91/nvim-bqf' },
  -- Overview of code
  {
    'stevearc/aerial.nvim',
    ft = { "python", "julia", "tex", "markdown", "typst" },
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = { { "<leader>a", "<cmd>AerialToggle<cr>" } },
    config = function()
      local aerial = require('aerial')
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '}', aerial.next, { buffer = bufnr })
          vim.keymap.set('n', '{', aerial.prev, { buffer = bufnr })
        end
      })
    end
  },
  -- Better display of errors
  {
    "folke/trouble.nvim",
    dependencies = "web-devicons",
    keys = {
      {"<leader>tt", "<cmd>TroubleToggle<cr>", "n"},
    }
  },
}
-- vim: set shiftwidth=2:
