return {
  -- Lazydev
  {
    "folke/lazydev.nvim",
    opts = {
      lspconfig = false,
      cmp = true,
    },
  },
  -- Mason
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "arduino_language_server",
          "basedpyright",
          "bashls",
          "clangd",
          "cssls",
          "docker_compose_language_service",
          "dockerls",
          "efm",
          "eslint",
          "fortls",
          "html",
          "jsonls",
          "julials",
          "ltex",
          "lua_ls",
          "marksman",
          "ruff",
          "rust_analyzer",
          "taplo",
          "tinymist",
          "ts_ls",
        },
      })
    end,
  },
  -- Conform: formatting
  {
    "stevearc/conform.nvim",
    opts = {},
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "nvim-lspconfig",
    },
    config = function(_, opts)
      local conform = require("conform")
      -- local mason = require('mason')
      -- local mason_registry = require('mason-registry')

      vim.keymap.set("n", "gq", function()
        conform.format({ lsp_fallback = true })
      end)

      conform.setup({
        lsp_fallback = true,
        formatters = {
          findent = {
            args = { "--continuation", "0", "--input_format", "fixed", "--indent_procedure", "0" },
          },
          ["bibtex-tidy"] = {
            args = { "--v2", "--curly", "--align", "14", "--no-escape", "--sort-fields", "--sort" },
          },
          latexindent = {
            args = { "-m", "--yaml", "defaultIndent: '  '", "-" },
          },
          stylua = {
            args = {
              "--indent-type",
              "Spaces",
              "--indent-width",
              "2",
              "--search-parent-directories",
              "--stdin-filepath",
              "$FILENAME",
              "-",
            },
          },
          shfmt = {
            args = { "--case-indent", "--indent", "4", "-filename", "$FILENAME" },
          },
          prettypst = {
            args = {
              "--use-std-in",
              "--use-std-out",
              "--file-location",
              "$FILENAME",
            },
          },
        },
        formatters_by_ft = {
          bash = { "shfmt" },
          bib = { "bibtex-tidy" },
          c = { "astyle" },
          cls = { "latexindent" },
          css = { "prettier" },
          fortran = { "findent" },
          html = { "htmlbeautifier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          lua = { "stylua" },
          python = { "ruff_organize_imports", "ruff_format" },
          rust = { "rustfmt" },
          scss = { "prettier" },
          sh = { "shfmt" },
          sty = { "latexindent" },
          tex = { "latexindent" },
          toml = { "taplo" },
          typst = { "prettypst" },
          yaml = { "yamlfmt" },
        },
      })
    end,
  },
  -- Function signatures
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
    opts = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      hint_enable = true,
      doc_lines = 0,
      floating_window = false,
      toggle_key = "<C-h>",
      select_signature_key = "<C-l>",
      floating_window_above_cur_line = true,
      handler_opts = {
        border = "rounded",
      },
    },
  },
}
-- vim: set shiftwidth=2:
