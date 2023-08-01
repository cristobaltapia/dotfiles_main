-- Define hints for hydra
local hint_diagram = [[
 Arrow^^^^^^   Select region with <C-v>
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^                      _q_
]]

local hint_git = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
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
          buffer = bufnr,
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
          { 'J',
            function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next hunk' } },
          { 'K',
            function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev hunk' } },
          { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
          { 'u', gitsigns.undo_stage_hunk,   { desc = 'undo last stage' } },
          { 'S', gitsigns.stage_buffer,      { desc = 'stage buffer' } },
          { 'p', gitsigns.preview_hunk,      { desc = 'preview hunk' } },
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

      -- Change language for ltex
      Hydra({
        name = 'Change Ltex language',
        hint = hint_ltex,
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
        body = '<leader>hl',
        heads = {
          { 'e', function()
            require("lspconfig").ltex.setup({ settings = { ltex = { language = "en-US" } } })
            vim.opt.spelllang = "en_us"
          end },
          { 'd', function()
            require("lspconfig").ltex.setup({ settings = { ltex = { language = "de-DE" } } })
            vim.opt.spelllang = "de_de"
          end },
          { 's', function()
            require("lspconfig").ltex.setup({ settings = { ltex = { language = "es" } } })
            vim.opt.spelllang = "es"
          end },
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
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  -- Different nice improvements for neovim
  {
    'echasnovski/mini.nvim',
    branch = 'main',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local animate = require('mini.animate')
      require('mini.trailspace').setup()
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
    end
  },
  -- Follow symlinks
  {
    'aymericbeaumet/vim-symlink',
    -- 'Jasha10/vim-symlink',
    dependencies = { 'moll/vim-bbye' },
    branch = "neovim0.9-autocmd-issue",
  },
}
-- vim: set shiftwidth=2:
