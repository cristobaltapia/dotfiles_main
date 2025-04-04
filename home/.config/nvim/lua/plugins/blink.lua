return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
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
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "default",
        ["<C-n>"] = { "show", "select_next", "fallback" },
        ["<C-c>"] = { "cancel" },
        ["<C-space>"] = {
          function()
            local blink = require("blink-cmp")
            if blink.is_visible() then
              -- Insert text if the selection is a path and replace otherwise.
              blink.select_and_accept()
            else
              vim.fn["UltiSnips#ExpandSnippet"]()
            end
          end,
        },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
        keyword = { range = "prefix" },
        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer" }
          elseif vim.bo.filetype == "lua" then
            return { "lsp", "path" }
          elseif vim.bo.filetype == "dap-repl" then
            return { "dap" }
          elseif vim.bo.filetype == "tex" then
            return { "vimtex", "ultisnips", "path", "latex_symbols", "buffer" }
          else
            return { "lsp", "path", "ultisnips" }
          end
        end,
        providers = {
          ultisnips = {
            name = "ultisnips",
            module = "blink.compat.source",
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
          },
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
          },
          dap = {
            name = "dap",
            module = "blink.compat.source",
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
