return {
  -- Note-taking utilities
  {
    'lervag/wiki.vim',
    -- ft = { "wiki" },
    dependencies = {
      { 'lervag/wiki-ft.vim' },
    },
    tag = "v0.8",
    cmd = "WikiIndex",
    init = function()
      vim.g.vimwiki_pubs_config = {
        vim.env.HOME .. "/.config/pubs/main_library.conf",
        vim.env.HOME .. "/.config/pubs/misc_library.conf",
      }

      vim.g.wiki_root = '~/Nextcloud/Notes'
      vim.g.wiki_link_creation = {
        wiki = {
          link_type = "wiki",
          url_extension = ".wiki",
          url_transform = function(x)
            local name
            name, _ = string.gsub(string.lower(x), " ", "-")
            return name
          end
        }
      }
      vim.g.wiki_filetypes = { 'wiki' }
      vim.g.wiki_select_method = 'fzf'
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
    init = function()
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
