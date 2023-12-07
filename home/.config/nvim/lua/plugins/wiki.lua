return {
  -- Note-taking utilities
  {
    'lervag/wiki.vim',
    -- ft = { "wiki" },
    dependencies = {
      { 'lervag/wiki-ft.vim' },
    },
    -- tag = "v0.8",
    lazy = true,
    cmd = "WikiIndex",
    init = function()
      -- Root folder
      vim.g.wiki_root = '~/Nextcloud/Notes'
      -- Keymaps
      vim.api.nvim_set_keymap("n", "<leader>wst", ":WikiTags<cr>" , {desc = "Search tags."})
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
            name, _ = string.gsub(string.lower(x), "[ :]",
              { [" "] = "-", [":"] = "" }
            )
            return name
          end
        }
      }
      -- Filetypes
      vim.g.wiki_filetypes = { 'wiki' }
    end,
    config = function()
      vim.opt.autochdir = true
    end
  },
  {
    'dkarter/bullets.vim',
    ft = {
      "gitcommit",
      "mail",
      "markdown",
      "markdown.pandoc",
      "pandoc",
      "text",
      "wiki",
    },
    config = function()
      vim.g.bullets_enabled_file_types = {
        'gitcommit',
        'mail',
        'markdown',
        'markdown.pandoc',
        'pandoc',
        'text',
        'wiki',
      }
    end
  },
}
-- vim: set shiftwidth=2:
