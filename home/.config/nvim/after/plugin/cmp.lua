-- Configuration for cmp
--
-- This configures the autocompletion menu
local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

local border = {
    { "╭", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╮", "CmpBorder" },
    { "│", "CmpBorder" },
    { "╯", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╰", "CmpBorder" },
    { "│", "CmpBorder" },
}

-- Define mappings for cmp
local neogen = require('neogen')
local cmp_mappings = {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select_opts),
    ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
                print("here 1")
                cmp.confirm({ select = true, behavior = 'replace' })
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
    ['<C-e>'] = cmp.mapping.abort(),
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

local cmp_config = {
    -- Disable autocompletion for comments
    enabled = function()
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    -- Define sources to be used
    sources = {
        { name = "nvim_lsp",  priority = 0 },
        { name = "ultisnips", priority = 1 },
        { name = "path",      priority = 2 },
        { name = "latex_symbols",      priority = 2 },
        { name = 'buffer',    keyword_length = 2 },
    },
    mapping = cmp_mappings,
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    experimental = {
        ghost_text = true,
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
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline', keyword_length = 2 }
        })
    }),
}

cmp.setup(cmp_config)
