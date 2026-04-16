return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    init = function()
      local ensure_installed = {
        "arduino",
        "bash",
        "bibtex",
        "comment",
        "css",
        "dockerfile",
        "javascript",
        "json",
        "julia",
        "lua",
        "make",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "typst",
        "vim",
        "vimdoc",
        "yaml",
        "yuck",
      }
      local alreadyInstalled = require("nvim-treesitter.config").get_installed()
      local parsersToInstall = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require("nvim-treesitter").install(parsersToInstall)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          -- Enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start)
          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
        end,
      })

      -- keymaps
      -- You can use the capture groups defined in `textobjects.scm`
      vim.keymap.set({ "x", "o" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end)
    end,
    config = function(_, opts)
      require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Foldings
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldnestmax = 3
      vim.opt.foldenable = false

      vim.cmd("hi pythonTSParameter guifg=#b48ead")
      vim.cmd("hi TSConstant guifg=#ebcb8b")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
  -- { "nvim-treesitter/playground" },
}
-- vim: set shiftwidth=2:
