return {
  -- Note-taking utilities
  {
    "lervag/wiki.vim",
    -- ft = { "wiki" },
    dependencies = {
      { "lervag/wiki-ft.vim" },
      { "nabla" },
    },
    lazy = true,
    cmd = "WikiIndex",
    init = function()
      -- Root folder
      vim.g.wiki_root = "~/Nextcloud/Notes"
      -- Keymaps
      vim.api.nvim_set_keymap("n", "<leader>wst", ":WikiTags<cr>", { desc = "Search tags." })
      -- Define location of pubs libraries
      vim.g.vimwiki_pubs_config = {
        vim.env.HOME .. "/.config/pubs/main_library.conf",
        vim.env.HOME .. "/.config/pubs/misc_library.conf",
      }
      -- Creation of links
      vim.g.wiki_link_creation = {
        wiki = {
          link_type = "wiki",
          url_extension = ".wiki",
          url_transform = function(x)
            local name
            name, _ = string.gsub(string.lower(x), "[ :]", { [" "] = "-", [":"] = "" })
            return name
          end,
        },
      }
      -- Filetypes
      vim.g.wiki_filetypes = { "wiki" }
    end,
    config = function()
      vim.opt.autochdir = true
    end,
  },
  {
    "bullets-vim/bullets.vim",
    ft = {
      "gitcommit",
      "mail",
      "markdown",
      "markdown.pandoc",
      "pandoc",
      "text",
      "wiki",
    },
    init = function()
      vim.g.bullets_enabled_file_types = {
        "gitcommit",
        "mail",
        "markdown",
        "markdown.pandoc",
        "pandoc",
        "text",
        "wiki",
      }
    end,
  },
  {
    "jbyuki/nabla.nvim",
    ft = { "wiki" },
    name = "nabla",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "<localleader>p",
        function()
          require("nabla").popup()
        end,
      },
      {
        "<localleader>vv",
        function()
          require("nabla").toggle_virt({ autogen = true })
        end,
      },
    },
  },
}
-- vim: set shiftwidth=2:
