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
    "mbbill/undotree",
    keys = {
      { "<F3>", "<cmd>UndotreeToggle<cr>", "n" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = true
    end,
  },
  -- Web devicons
  { "nvim-tree/nvim-web-devicons", name = "web-devicons" },
  -- Better ui elements for nvim
  { "stevearc/dressing.nvim" },
  -- Char-based diff
  {
    "rickhowe/diffchar.vim",
    ft = { "markdown", "markdown.pandoc", "tex" },
  },
  -- Better movements
  {
    "ggandor/leap.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
      local leap = require("leap")

      vim.keymap.set("n", "l", "<Plug>(leap)", { noremap = true })
      vim.keymap.set({ "x", "o" }, "l", "<Plug>(leap-forward)", { noremap = true })
      vim.keymap.set({ "x", "o" }, "L", "<Plug>(leap-backward)", { noremap = true })

      leap.opts.safe_labels = {}
      -- stylua: ignore start
      leap.opts.labels = {
        "s", "i", "e", "t", "n", "r", "b", "a", "u", "y", "m",
        "l", "g", "h", "d", "f", "S", "I", "E", "T", "N", "R",
        "B", "A", "U", "Y", "M", "L", "G", "H", "D", "F"}
      -- stylua: ignore end
    end,
  },
  -- Hydra
  {
    "anuvyklack/hydra.nvim",
    name = "hydra",
    lazy = true,
    keys = {
      "<leader>hd",
      "<leader>hl",
    },
    config = function(_, opts)
      local Hydra = require("hydra")

      Hydra({
        name = "Draw Diagram",
        hint = hint_diagram,
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            border = "rounded",
          },
          on_enter = function()
            vim.o.virtualedit = "all"
          end,
        },
        mode = "n",
        body = "<leader>hd",
        heads = {
          { "H", "<C-v>h:VBox<CR>" },
          { "J", "<C-v>j:VBox<CR>" },
          { "K", "<C-v>k:VBox<CR>" },
          { "L", "<C-v>l:VBox<CR>" },
          { "f", ":VBox<CR>", { mode = "v" } },
          { "q", nil, { exit = true } },
        },
      })

      local ltex_ft = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "typst" }
      -- Change language for ltex
      Hydra({
        name = "Change Ltex language",
        hint = hint_ltex,
        config = {
          color = "teal",
          invoke_on_body = true,
          hint = {
            border = "rounded",
          },
          on_enter = function()
            vim.o.virtualedit = "all"
          end,
        },
        mode = "n",
        body = "<leader>hl",
        heads = {
          {
            "e",
            function()
              require("lspconfig").ltex.setup({ filetypes = ltex_ft, settings = { ltex = { language = "en-US" } } })
              vim.opt.spelllang = "en_us"
            end,
            { exit_before = true },
          },
          {
            "d",
            function()
              require("lspconfig").ltex.setup({ filetypes = ltex_ft, settings = { ltex = { language = "de-DE" } } })
              vim.opt.spelllang = "de_de"
            end,
            { exit_before = true },
          },
          {
            "s",
            function()
              require("lspconfig").ltex.setup({ filetypes = ltex_ft, settings = { ltex = { language = "es" } } })
              vim.opt.spelllang = "es"
            end,
          },
          { "q", nil, { exit = true } },
        },
      })
    end,
  },
  -- Docstrings generator (neogen)
  {
    "danymat/neogen",
    keys = {
      { "<leader>ds", "<cmd>Neogen func<cr>", desc = "Generate func docstrings" },
      { "<leader>dc", "<cmd>Neogen class<cr>", desc = "Generate class docstrings" },
    },
    config = function()
      local neogen = require("neogen")

      vim.keymap.set({ "i", "v" }, "<C-e>", neogen.jump_next)

      neogen.setup({
        enabled = true,
        input_after_comment = true,
        languages = {
          python = {
            template = {
              annotation_convention = "numpydoc",
            },
          },
        },
      })
    end,
  },
  -- Surround movements
  { "tpope/vim-surround" },
  -- Close pairs of parentheses, quotes, etc
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  -- Mini.nvim plugins
  {
    "echasnovski/mini.nvim",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>m", ":lua MiniFiles.open()<cr>", "n" },
      { "<leader>go", ":lua MiniDiff.toggle_overlay()<cr>", "n" },
    },
    config = function()
      require("mini.trailspace").setup()
      require("mini.files").setup({
        mappings = {
          go_in = "<Right>",
          go_in_plus = "<cr>",
          go_out = "<Left>",
          go_out_plus = "t",
        },
      })
      require("mini.indentscope").setup()
      local animate = require("mini.animate")
      require("mini.animate").setup({
        cursor = { enable = false },
        resize = { enable = true },
        scroll = { enable = false, timing = animate.gen_timing.linear({ duration = 150, unit = "total" }) },
      })
      require("mini.visits").setup()
      require("mini.diff").setup({
        view = {
          style = "number",
        },
        options = {
          wrap_goto = false,
        },
      })
      -- Set keybindings
      vim.keymap.set("n", "<leader>pp", MiniVisits.select_path)
    end,
  },
  {
    "echasnovski/mini.notify",
    version = false,
    ft = { "julia", "rust" },
    config = function()
      require("mini.notify").setup()
    end,
  },
  -- Support for openning GNUGP excrypted files
  { "jamessan/vim-gnupg" },
  -- Draw ascii diagrams
  {
    "jbyuki/venn.nvim",
    dependencies = { "hydra" },
  },
  -- Snippets
  {
    "SirVer/ultisnips",
    dependencies = {
      { "honza/vim-snippets" },
      { "cristobaltapia/MySnippets" },
    },
    config = function()
      vim.g.UltiSnipsSnippetDirectories = {
        "UltiSnips",
        vim.env.HOME .. "/.local/share/nvim/lazy/MySnippets/Ultisnips",
        vim.env.HOME .. "/Templates/ultisnips-templates",
      }

      -- Set the smart function definition to use numpy style for docstrings
      vim.g.ultisnips_python_style = "numpy"
      vim.g.UltisnipsUsePythonVersion = 3
      vim.g.UltiSnipsJumpForwardTrigger = "<c-e>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-a>"
    end,
  },
  -- Follow symlinks
  -- {
  --   'aymericbeaumet/vim-symlink',
  --   -- 'Jasha10/vim-symlink',
  --   dependencies = { 'moll/vim-bbye' },
  -- },
  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTEditWithInstructions" },
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        keymaps = {
          close = "<C-c>",
        },
        api_key_cmd = "cat " .. home .. "/.config/chatgpt/api",
        actions_paths = { vim.env.HOME .. "/.config/chatgpt/actions.json" },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
-- vim: set shiftwidth=2:
