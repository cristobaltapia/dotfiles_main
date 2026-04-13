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
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
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
          -- "julials",
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
          ["clang-format"] = {
            args = { "--style", "LLVM" },
          },
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
          kdlfmt = {
            command = "kdlfmt",
            args = { "format", "-" },
            stdin = true,
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
          cpp = { "clang-format" },
          css = { "prettier" },
          fortran = { "findent" },
          html = { "htmlbeautifier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          kdl = { "kdlfmt" },
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
}
-- vim: set shiftwidth=2:
