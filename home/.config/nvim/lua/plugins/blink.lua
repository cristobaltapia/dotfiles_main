return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "v1.7.0",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    name = "nvim-cmp",
    enabled = false,
  },
  {
    "saghen/blink.cmp",

    -- optional: provides snippets for the snippet source
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "kdheepak/cmp-latex-symbols" },
      { "rcarriga/cmp-dap" },
      {
        "cristobaltapia/cmp-nvim-ultisnips",
        branch = "fix-performance",
        name = "cmp-nvim-ultisnips",
        enabled = true,
        lazy = "true",
      },
      { "micangl/cmp-vimtex" },
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "none",
        ["<C-p>"] = { "show", "select_prev", "fallback" },
        ["<C-n>"] = { "show", "select_next", "fallback" },
        ["<C-c>"] = { "cancel" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        -- ["<C-space>"] = {
        --   function()
        --     local blink = require("blink-cmp")
        --     -- if blink.is_visible() then
        --     if blink.is_menu_visible() then
        --       -- Insert text if the selection is a path and replace otherwise.
        --       blink.select_and_accept()
        --     else
        --       vim.cmd("call UltiSnips#ExpandSnippet()")
        --     end
        --   end,
        -- },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
        keyword = { range = "prefix" },
        trigger = {},
        menu = {
          auto_show_delay_ms = 500,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind",              gap = 1 },
            },
          },
        },
      },

      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer" }
          elseif vim.bo.filetype == "lua" then
            return { "lsp", "path" }
          elseif vim.bo.filetype == "dap-repl" then
            return { "dap" }
          elseif vim.bo.filetype == "julia" then
            return { "lsp", "ultisnips", "path", "latex_symbols" }
          elseif vim.bo.filetype == "tex" then
            return { "vimtex", "ultisnips", "path", "buffer" }
          else
            return { "lsp", "path", "ultisnips" }
          end
        end,
        min_keyword_length = 2,
        providers = {
          lsp = {
            timeout_ms = 1000,
            async = true,
          },
          ultisnips = {
            name = "ultisnips",
            module = "blink.compat.source",
            score_offset = 1,
            opts = {
              entry_filter = function(entry, ctx)
                local context = require("cmp.config.context")
                local in_capture = context.in_treesitter_capture
                return not in_capture("comment")
                    and not in_capture("string.documentation")
                    and not context.in_syntax_group("Comment")
              end,
            },
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 5,
            min_keyword_length = 1,
          },
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
          },
          dap = {
            name = "dap",
            module = "blink.compat.source",
          },
          buffer = {
            score_offset = -100,
            min_keyword_length = 5,
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
