return {
  -- Colorschemes
  {
    'shaunsingh/nord.nvim',
    name = 'nord',
    config = function()
      vim.cmd('colorscheme nord')
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ebcb8b", bold = true })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#434c5e" })
    end
  },
  -- Tmux
  {
    'jpalardy/vim-slime',
    keys = {
      { "<C-c><C-c>", mode = "n" },
      { "<C-c><C-c>", mode = "v" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "0.1" }
      vim.g.slime_bracketed_paste = 1
    end
  },
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      extensions = { 'quickfix', 'fugitive' },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_z = { function()
          return [[buffers]]
        end },
      },
    },
  },
  -- FZF support
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf', build = './install --all' },
    },
  },
  -- Integration with tmux
  {
    'christoomey/vim-tmux-navigator',
    lazy = true,
    keys = {
      { "<A-h>", "<cmd>TmuxNavigateLeft<cr>",  "n", { silent = true } },
      { "<A-j>", "<cmd>TmuxNavigateDown<cr>",  "n", { silent = true } },
      { "<A-k>", "<cmd>TmuxNavigateUp<cr>",    "n", { silent = true } },
      { "<A-l>", "<cmd>TmuxNavigateRight<cr>", "n", { silent = true } },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = true
    end
  },
  -- Nice visualization of quickfix errors
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      function _G.qftf(info)
        local items
        local ret = {}
        if info.quickfix == 1 then
          items = vim.fn.getqflist({ id = info.id, items = 0 }).items
        else
          items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
        end
        local limit = 31
        local fname_fmt1, fname_fmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
        local valid_fmt = '%s │%5d:%2d│%s %s'
        for i = info.start_idx, info.end_idx do
          local e = items[i]
          local fname = ''
          local str
          if e.valid == 1 then
            if e.bufnr > 0 then
              fname = vim.fn.bufname(e.bufnr)
              if fname == '' then
                fname = '[No Name]'
              else
                fname = fname:gsub('^' .. vim.env.HOME, '~')
              end
              -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
              if #fname <= limit then
                fname = fname_fmt1:format(fname)
              else
                fname = fname_fmt2:format(fname:sub(1 - limit))
              end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local cnum = e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            if qtype == '' then
              qtype = ' ->'
            end
            str = valid_fmt:format(fname, lnum, cnum, qtype, e.text)
          else
            str = e.text
          end
          table.insert(ret, str)
        end
        return ret
      end

      vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

      require('bqf').setup()
    end
  },
  -- Overview of code
  {
    'stevearc/aerial.nvim',
    ft = { "python", "julia", "tex", "markdown", "typst" },
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = { { "<leader>a", "<cmd>AerialToggle<cr>" } },
    config = function()
      local aerial = require('aerial')
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '}', aerial.next, { buffer = bufnr })
          vim.keymap.set('n', '{', aerial.prev, { buffer = bufnr })
        end
      })
    end
  },
  -- Better display of errors
  {
    "folke/trouble.nvim",
    dependencies = "web-devicons",
    keys = {
      { "<leader>tt", "<cmd>TroubleToggle<cr>", "n" },
    }
  },
}
-- vim: set shiftwidth=2:
