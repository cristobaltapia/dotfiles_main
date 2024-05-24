return {
  {
    'cristobaltapia/cmp-nvim-ultisnips',
    branch = 'fix-performance',
    name = 'cmp-nvim-ultisnips',
    lazy = 'true',
  },
  {
    'hrsh7th/nvim-cmp',
    name = "nvim-cmp",
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "danymat/neogen" },
      { 'hrsh7th/cmp-buffer', },
      { 'hrsh7th/cmp-omni', },
      { 'hrsh7th/cmp-path', },
      { 'hrsh7th/cmp-nvim-lsp', },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', },
      { 'hrsh7th/cmp-cmdline', },
      { "davidsierradz/cmp-conventionalcommits", },
      -- { 'quangnguyen30192/cmp-nvim-ultisnips', },
      { 'cmp-nvim-ultisnips', },
      -- { dir = '/home/tapia/git_repos/Meine/cmp-nvim-ultisnips/', },
      { 'rose-pine/neovim' },
      { 'windwp/nvim-autopairs' },
      { "micangl/cmp-vimtex" },
      { "rcarriga/cmp-dap" },
    },
    -- Configuration
    config = function()
      local cmp = require('cmp')
      local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
      local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
      local cmp_lsp = require("cmp.types.lsp")

      -- Define mappings for cmp
      local neogen = require('neogen')
      local cmp_mappings = {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
              -- Insert text if the selection is a path and replace otherwise.
              local sel_source = cmp.get_active_entry()
              if sel_source == nil then
                cmp.select_next_item()
                sel_source = cmp.get_active_entry()
              end

              if cmp_lsp.CompletionItemKind[sel_source:get_kind()] ~= 'Path' then
                cmp.confirm({ select = true, behavior = 'insert' })
              else
                cmp.confirm({ select = true, behavior = 'replace' })
              end
            else
              vim.fn["UltiSnips#ExpandSnippet"]()
            end
          end,
          { "i", "s" }
        ),
        -- ['<C-Space>'] = cmp.mapping.complete(cmp_select),
        ["<C-j>"] = cmp.mapping(
          function(fallback)
            if neogen.jumpable() then
              neogen.jump_next()
            else
              cmp_ultisnips_mappings.jump_forwards(fallback)
            end
          end,
          { "i", "s" }
        ),
        ["<C-z>"] = cmp.mapping(
          function(fallback)
            if neogen.jumpable(true) then
              neogen.jump_prev()
            else
              cmp_ultisnips_mappings.jump_backwards(fallback)
            end
          end,
          { "i", "s" }
        ),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-e>'] = cmp.mapping.abort(),
      }

      -- Add parenthesis automatically after functions
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      -- Define colors for the suggestion menu of nvim-cmp
      local p = require('rose-pine.palette')

      vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = p.foam })
      vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = p.gold })
      vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = p.gold })
      vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = p.iris })
      vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = p.iris })
      vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = p.iris })
      vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = p.subtle })
      vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = p.subtle })

      local context = require('cmp.config.context')
      local in_capture = context.in_treesitter_capture

      local cmp_config = {
        -- Define sources to be used
        sources = {
          {
            name = "nvim_lsp",
            priority = 9,
            keyword_length = 2,
            -- Disable source for comments
            entry_filter = function(entry, ctx)
              return not in_capture("comment") and not in_capture("string.documentation")
                  and not context.in_syntax_group("Comment")
            end
          },
          { name = 'omni' },
          {
            name = "ultisnips",
            priority = 10,
            -- Disable source for comments
            entry_filter = function(entry, ctx)
              return not in_capture("comment") and not in_capture("string.documentation")
                  and not context.in_syntax_group("Comment")
            end
          },
          {
            name = "path",
            option = { trailin_slash = true },
            priority = 4
          },
          { name = "latex_symbols", priority = 2 },
          {
            name = 'buffer',
            keyword_length = 3,
            option = {
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end
            }
          },
        },
        mapping = cmp_mappings,
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        experimental = {
          ghost_text = { hl_group = 'DevIconCMake' },
        },
        performance = {
          max_view_entries = 40,
          fetching_timeout = 200,
        },
        formatting = {
          fields = { 'abbr', 'menu', 'kind' },
          format = function(entry, item)
            local short_name = {
              nvim_lsp = 'LSP',
              nvim_lua = 'nvim'
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.sort_text,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          }
        },
        window = {
          completion = {
            winhighlight = "Normal:StatusLineNC,CursorLine:Substitute",
          },
          documentation = {
            winhighlight = 'FloatBorder:WildMenu',
            border = "rounded",
          }
        },

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        }),

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          completion = { autocomplete = false },
          sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
          }),
        }
        ),
      }

      cmp.setup(cmp_config)
    end
  },
  {
    "kdheepak/cmp-latex-symbols",
    ft = "julia",
    dependencies = { "nvim-cmp" }
  },
}
-- vim: set shiftwidth=2:
