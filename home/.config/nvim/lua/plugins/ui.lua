return {
  -- Colorschemes
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local nordic = require("nordic")
      local palette = require("nordic.colors")
      local opts = {
        -- Enable bold keywords.
        bold_keywords = true,
        -- Enable italic comments.
        italic_comments = true,
        -- Enable general editor background transparency.
        transparent = {
          bg = false,
        },
        -- Enable brighter float border.
        bright_border = false,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = false,
        -- Swap the dark background with the normal one.
        swap_backgrounds = true,
        -- Override the styling of any highlight group.
        on_highlight = function(highlights, palette_nordic)
          highlights.Visual = { bg = palette_nordic.grey2 }
          highlights.FloatBorder = {
            fg = palette_nordic.yellow.base,
            bold = true,
          }
          highlights.NormalFloat = { bg = palette_nordic.grey2 }
          highlights.WikiLinkWiki = {
            fg = palette_nordic.blue1,
            underline = true,
          }
          -- Color for the scrollbar in cmp
          highlights.PmenuThumb = { bg = palette_nordic.blue0 }
        end,
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = false,
          -- Bold cursorline number.
          bold_number = true,
          -- Available styles: 'dark', 'light'.
          theme = "dark",
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        noice = {
          -- Available styles: `classic`, `flat`.
          style = "classic",
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = "classic",
        },
        leap = {
          -- Dims the backdrop when using leap.
          dim_backdrop = false,
        },
        ts_context = {
          -- Enables dark background for treesitter-context window
          dark_background = true,
        },
      }
      -- opts.override['Underlined'] = { fg = palette.cyan.base }
      nordic.setup(opts)

      nordic.load()
    end,
  },
  -- Multicursor
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- stylua: ignore start
      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<c-up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<c-down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><c-up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader><c-down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
      set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
      set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
      set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)
      -- stylua: ignore end

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Align cursor columns.
      set("n", "<leader>ac", mc.alignCursors)

      -- Split visual selections by regex.
      set("x", "<leader>S", mc.splitCursors)

      -- stylua: ignore start
      -- Rotate the text contained in each visual selection between cursors.
      set("x", "<leader>t", function() mc.transposeCursors(1) end)
      set("x", "<leader>T", function() mc.transposeCursors(-1) end)
      -- stylua: ignore end

      vim.keymap.set("n", "<leader>cc", function()
        mc.addCursor("w")
      end)

      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  -- Tmux
  {
    "jpalardy/vim-slime",
    keys = {
      { "<C-c><C-c>", mode = "n" },
      { "<C-c><C-c>", mode = "v" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "0.1" }
      vim.g.slime_bracketed_paste = 1
    end,
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      extensions = { "quickfix", "fugitive" },
      tabline = {
        lualine_a = { "buffers" },
        lualine_z = {
          function()
            return [[buffers]]
          end,
        },
      },
    },
  },
  -- FZF support
  {
    "junegunn/fzf.vim",
    dependencies = {
      { "junegunn/fzf", build = "./install --all" },
    },
  },
  -- Integration with tmux
  {
    "christoomey/vim-tmux-navigator",
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
    end,
  },
  -- Nice visualization of quickfix errors
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

      require("bqf").setup()
      vim.api.nvim_set_hl(0, "BqfPreviewTitle", { bg = "#ebcb8b", fg = "#3b4252" })
    end,
  },
  -- Overview of code
  {
    "stevearc/aerial.nvim",
    ft = { "python", "julia", "tex", "markdown", "typst" },
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = { { "<leader>a", "<cmd>AerialToggle<cr>" } },
    config = function()
      local aerial = require("aerial")
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "}", aerial.next, { buffer = bufnr })
          vim.keymap.set("n", "{", aerial.prev, { buffer = bufnr })
        end,
      })
    end,
  },
  -- Better display of errors
  {
    "folke/trouble.nvim",
    dependencies = "web-devicons",
    keys = {
      { "<leader>tt", "<cmd>Trouble<cr>", "n" },
    },
    cmd = { "Trouble" },
    opts = { focus = true },
  },
  {
    "m00qek/baleia.nvim",
    config = function()
      local baleia = require("baleia").setup({
        strip_ansi_codes = true,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function()
          baleia.automatically(vim.api.nvim_get_current_buf())
        end,
      })
    end,
  },
  -- Buffer search (snipe)
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      hints = {
        -- Characters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
        dictionary = "etinsrchabumyl",
      },
    },
  },
}
-- vim: set shiftwidth=2:
