-- Define hints for hydra
local hint_diagram = [[
 Arrow^^^^^^   Select region with <C-v>
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^                      _q_
]]

local hint_git = [[
 _n_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _p_: prev hunk   _u_: undo last stage   _P_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Fugitive              _q_: exit
]]

local hint_ltex = [[
 ^^   Select Language for Ltex ^
^ ^
 _e_: English (American) ^
 _d_: German (Germany) ^
 _s_: Spanish
^ ^
 _q_: Exit
]]

return {
  -- Undo history
  {
    'mbbill/undotree',
    keys = {
      { "<F3>", "<cmd>UndotreeToggle<cr>", "n" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = true
    end
  },
  -- Web devicons
  { "nvim-tree/nvim-web-devicons", name = "web-devicons" },
  -- Better ui elements for nvim
  { 'stevearc/dressing.nvim' },
  -- Char-based diff
  {
    'rickhowe/diffchar.vim',
    ft = { 'markdown', 'markdown.pandoc', 'tex' }
  },
  {
    'b3nj5m1n/kommentary',
    branch = 'main',
    config = function()
      require('kommentary.config').configure_language("julia", {
        single_line_comment_string = "#",
        prefer_single_line_comments = true,
      })
      require('kommentary.config').configure_language("lua", {
        prefer_single_line_comments = true,
      })
    end
  },
  -- Better movements
  {
    'ggandor/leap.nvim',
    keys = {
      { "s", "<Plug>(leap-forward-to)",  "n", { silent = true } },
      { "S", "<Plug>(leap-backward-to)", "n", { silent = true } },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      local leap = require('leap')
      leap.opts.safe_labels = {}
      leap.opts.labels = { "s", "i", "e",
        "t", "n", "r", "b", "a", "u", "y", "m", "l", "g", "h", "d", "f",
        "S", "I", "E",
        "T", "N", "R", "B", "A", "U", "Y", "M", "L", "G", "H", "D", "F",
      }
    end
  },
  -- Hydra
  {
    'anuvyklack/hydra.nvim',
    name = "hydra",
    lazy = true,
    keys = {
      "<leader>g", "<leader>hd", "<leader>hl",
    },
    config = function(_, opts)
      local Hydra = require('hydra')

      Hydra({
        name = 'Draw Diagram',
        hint = hint_diagram,
        config = {
          color = 'pink',
          invoke_on_body = true,
          hint = {
            border = 'rounded'
          },
          on_enter = function()
            vim.o.virtualedit = 'all'
          end,
        },
        mode = 'n',
        body = '<leader>hd',
        heads = {
          { 'H', '<C-v>h:VBox<CR>' },
          { 'J', '<C-v>j:VBox<CR>' },
          { 'K', '<C-v>k:VBox<CR>' },
          { 'L', '<C-v>l:VBox<CR>' },
          { 'f', ':VBox<CR>',      { mode = 'v' } },
          { 'q', nil,              { exit = true } },
        }
      })

      local gitsigns = require('gitsigns')

      Hydra({
        name = 'Git',
        hint = hint_git,
        config = {
          color = 'pink',
          invoke_on_body = true,
          hint = {
            border = 'rounded'
          },
          on_enter = function()
            vim.cmd 'mkview'
            vim.cmd 'silent! %foldopen!'
            vim.bo.modifiable = false
            gitsigns.toggle_signs(true)
            gitsigns.toggle_linehl(true)
            gitsigns.toggle_word_diff(true)
          end,
          on_exit = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd 'loadview'
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd 'normal zv'
            gitsigns.toggle_signs(true)
            gitsigns.toggle_linehl(false)
            gitsigns.toggle_deleted(false)
            gitsigns.toggle_word_diff(false)
          end,
        },
        mode = { 'n', 'x' },
        body = '<leader>g',
        heads = {
          { 'n',
            function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next hunk' } },
          { 'p',
            function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev hunk' } },
          { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
          { 'u', gitsigns.undo_stage_hunk,   { desc = 'undo last stage' } },
          { 'S', gitsigns.stage_buffer,      { desc = 'stage buffer' } },
          { 'P', gitsigns.preview_hunk,      { desc = 'preview hunk' } },
          { 'd', gitsigns.toggle_deleted, {
            nowait = true,
            desc = 'toggle deleted'
          } },
          { 'b', gitsigns.blame_line,                                { desc = 'blame' } },
          { 'B', function() gitsigns.blame_line { full = true } end, { desc = 'blame show full' } },
          { '/', gitsigns.show, {
            exit = true,
            desc = 'show base file'
          } }, -- show the base of the file
          { '<Enter>', '<Cmd>Git<CR>', { exit = true, desc = 'Fugitive' } },
          { 'q', nil, {
            exit = true,
            nowait = true,
            desc = 'exit'
          } },
        }
      })

      local ltex_ft = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "typst" }
      -- Change language for ltex
      Hydra({
        name = 'Change Ltex language',
        hint = hint_ltex,
        config = {
          color = 'teal',
          invoke_on_body = true,
          hint = {
            border = 'rounded'
          },
          on_enter = function()
            vim.o.virtualedit = 'all'
          end,
        },
        mode = 'n',
        body = '<leader>hl',
        heads = {
          { 'e',
            function()
              require("lspconfig").ltex.setup({ filetypes = ltex_ft, settings = { ltex = { language = "en-US" } } })
              vim.opt.spelllang = "en_us"
            end,
            { exit_before = true }
          },
          { 'd',
            function()
              require("lspconfig").ltex.setup({ filetypes = ltex_ft, settings = { ltex = { language = "de-DE" } } })
              vim.opt.spelllang = "de_de"
            end,
            { exit_before = true }
          },
          { 's',
            function()
              require("lspconfig").ltex.setup({ filetypes = ltex_ft, settings = { ltex = { language = "es" } } })
              vim.opt.spelllang = "es"
            end,
          },
          { 'q', nil, { exit = true } },
        }
      })
    end
  },
  -- Docstrings generator
  {
    "danymat/neogen",
    keys = {
      { "<leader>ds", "<cmd>Neogen func<cr>",  desc = "Generate func docstrings" },
      { "<leader>dc", "<cmd>Neogen class<cr>", desc = "Generate class docstrings" },
    },
    opts = {
      enabled = true,
      input_after_comment = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'numpydoc',
          }
        }
      }
    },
  },
  -- Surround movements
  { 'tpope/vim-surround' },
  -- Close pairs of parentheses, quotes, etc
  {
    'windwp/nvim-autopairs',
    config = true,
  },
  -- Different nice improvements for neovim
  {
    'echasnovski/mini.nvim',
    branch = 'main',
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>m", ":lua MiniFiles.open()<cr>", "n" },
    },
    config = function()
      local animate = require('mini.animate')
      require('mini.trailspace').setup()
      require('mini.files').setup(
        {
          mappings = {
            go_in = '<Right>',
            go_in_plus = '<cr>',
            go_out = '<Left>',
            go_out_plus = 't',
          }
        })
      require('mini.indentscope').setup()
      require('mini.animate').setup({
        cursor = { enable = false },
        resize = { enable = true },
        scroll = { enable = false, timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }) }
      })
    end
  },
  -- Support for openning GNUGP excrypted files
  { 'jamessan/vim-gnupg' },
  -- Draw ascii diagrams
  {
    'jbyuki/venn.nvim',
    dependencies = { "hydra" },
  },
  -- Snippets
  {
    'SirVer/ultisnips',
    dependencies = {
      { 'honza/vim-snippets' },
      { 'cristobaltapia/MySnippets' }
    },
    config = function()
      vim.g.UltiSnipsSnippetDirectories = {
        'UltiSnips',
        vim.env.HOME .. '/.local/share/nvim/lazy/MySnippets/Ultisnips',
        vim.env.HOME .. '/Templates/ultisnips-templates'
      }

      -- Set the smart function definition to use numpy style for docstrings
      vim.g.ultisnips_python_style = "numpy"
      vim.g.UltisnipsUsePythonVersion = 3
      vim.g.UltiSnipsJumpForwardTrigger = "<c-e>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-a>"
    end
  },
  -- Follow symlinks
  -- {
  --   'aymericbeaumet/vim-symlink',
  --   -- 'Jasha10/vim-symlink',
  --   dependencies = { 'moll/vim-bbye' },
  -- },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTEditWithInstructions" },
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup(
        {
          api_key_cmd = "cat " .. home .. "/.config/chatgpt/api",
          actions_paths = { vim.env.HOME .. "/.config/chatgpt/actions.json" }
        }
      )
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}
-- vim: set shiftwidth=2:
