return {
  {
    "vim-pandoc/vim-pandoc",
    ft = { "markdown", "markdown.pandoc", "pandoc" },
    dependencies = {
      { "vim-pandoc/vim-pandoc-syntax" },
      { "godlygeek/tabular" },
      {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        init = function()
          vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown", "pandoc", "markdown.pandoc" },
      },
    },
    config = function()
      vim.cmd([[
    function! g:Open_browser(url)
    "silent exe 'silent !gnome-www-browser --private-instance ' . a:url . " &"
    silent exe 'silent !epiphany --private-instance ' . a:url . " &"
    endfunction
    ]])

      -- local function open_browser(url)
      --   io.popen("epiphany --private-instance " .. url .. " &")
      -- end
      vim.g.mkdp_browserfunc = "g:Open_browser"
      -- vim.g.mkdp_browser = "firefox"

      vim.g.mkdp_filetypes = { "pandoc", "markdown", "markdown.pandoc", "wiki" }
      vim.g.mkdp_auto_close = false
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = true, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    options = {
      filetypes = { "markdown", "quarto", "rmd" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  }
}
-- vim: set shiftwidth=2:
