return {
  -- Colorschemes
  -- {
  --   'shaunsingh/nord.nvim',
  --   name = 'nord',
  --   config = function()
  --     vim.cmd('colorscheme nord')
  --     vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ebcb8b", bold = true })
  --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#434c5e" })
  --     vim.cmd('hi! LspInlayHint guifg=#b48ead')
  --   end
  -- },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local nordic = require('nordic')
      local palette = require('nordic.colors')
      local opts = {
        -- Enable bold keywords.
        bold_keywords = true,
        -- Enable italic comments.
        italic_comments = true,
        -- Enable general editor background transparency.
        transparent_bg = false,
        -- Enable brighter float border.
        bright_border = false,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = false,
        -- Swap the dark background with the normal one.
        swap_backgrounds = true,
        -- Override the styling of any highlight group.
        override = {
          Visual = { bg = palette.grey2, },
          FloatBorder = { fg = palette.yellow.base, bold = true, },
          NormalFloat = { bg = palette.grey2, },
          WikiLinkWiki = { fg = palette.blue1, underline = true },
          SpellBad = { fg = palette.red.base, underline = true },
        },
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = false,
          -- Bold cursorline number.
          bold_number = true,
          -- Available styles: 'dark', 'light'.
          theme = 'dark',
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        noice = {
          -- Available styles: `classic`, `flat`.
          style = 'classic',
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = 'classic',
        },
        leap = {
          -- Dims the backdrop when using leap.
          dim_backdrop = false,
        },
        ts_context = {
          -- Enables dark background for treesitter-context window
          dark_background = true,
        }

      }
      -- opts.override['Underlined'] = { fg = palette.cyan.base }
      nordic.setup(opts)

      nordic.load()
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
      { "<A-h>",     "<cmd>TmuxNavigateLeft<cr>",  "n", { silent = true } },
      { "<A-j>",     "<cmd>TmuxNavigateDown<cr>",  "n", { silent = true } },
      { "<A-k>",     "<cmd>TmuxNavigateUp<cr>",    "n", { silent = true } },
      { "<A-l>",     "<cmd>TmuxNavigateRight<cr>", "n", { silent = true } },
      { "<A-left>",  "<cmd>TmuxNavigateLeft<cr>",  "n", { silent = true } },
      { "<A-down>",  "<cmd>TmuxNavigateDown<cr>",  "n", { silent = true } },
      { "<A-up>",    "<cmd>TmuxNavigateUp<cr>",    "n", { silent = true } },
      { "<A-right>", "<cmd>TmuxNavigateRight<cr>", "n", { silent = true } },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = true
    end
  },
  -- Nice visualization of quickfix errors
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

      require('bqf').setup()
      vim.api.nvim_set_hl(0, 'BqfPreviewTitle', { bg = '#ebcb8b', fg = '#3b4252' })
    end
  },
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
      { "<leader>tt", "<cmd>TroubleToggle<cr>", "n" },
    }
  },
  {
    'm00qek/baleia.nvim',
    config = function()
      local baleia = require('baleia').setup({})
      vim.api.nvim_create_autocmd(
        "FileType",
        {
          pattern = "dap-repl",
          callback = function()
            baleia.automatically(vim.fn.bufnr('%'))
          end
        })
    end
  }
}
-- vim: set shiftwidth=2:
