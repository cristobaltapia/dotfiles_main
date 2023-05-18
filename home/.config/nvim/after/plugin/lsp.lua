local Path = require("plenary.path")
require("neodev").setup { lspconfig = true, }

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- Define current bufnr
        local bufnr = event.buf
        local map = function(m, lhs, rhs)
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set(m, lhs, rhs, opts)
        end

        -- LSP actions
        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', 'go', vim.lsp.buf.type_definition)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', 'gs', vim.lsp.buf.signature_help)
        map('n', '<leader>rn', vim.lsp.buf.rename)
        map({ 'n', 'x' }, 'gq', function() vim.lsp.buf.format({ async = true }) end)
        -- Format selected code only
        vim.keymap.set('v', 'gq', function()
            vim.lsp.buf.format({
                async = true,
                timeout_ms = 10000,
                range = { vim.fn.getpos('v'), vim.fn.getcurpos() },
            })
        end)
        map('n', '<leader>ca', vim.lsp.buf.code_action)
        map('x', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

        -- Diagnostics
        map('n', 'gl', vim.diagnostic.open_float)
        map('n', '[d', vim.diagnostic.goto_prev)
        map('n', ']d', vim.diagnostic.goto_next)
    end
})

local function lsp_settings()
    vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded' },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
    )

    local command = vim.api.nvim_create_user_command

    command('LspWorkspaceAdd', function()
        vim.lsp.buf.add_workspace_folder()
    end, { desc = 'Add folder to workspace' })

    command('LspWorkspaceList', function()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = 'List workspace folders' })

    command('LspWorkspaceRemove', function()
        vim.lsp.buf.remove_workspace_folder()
    end, { desc = 'Remove folder from workspace' })
end

lsp_settings()

require('mason').setup({})
require('mason-lspconfig').setup({})

-- Configure all the other language servers
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            -- Disable telemetry
            telemetry = { enable = false },
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    -- Make the server aware of Neovim runtime files
                    vim.fn.expand('$VIMRUNTIME/lua'),
                    vim.fn.stdpath('config') .. '/lua'
                }
            }
        }
    }
}

lspconfig.pyright.setup {}
lspconfig.typst_lsp.setup { single_file_support = true }
lspconfig.julials.setup {}
lspconfig.texlab.setup {}
lspconfig.docker_compose_language_service.setup {}
lspconfig.dockerls.setup {
    on_attach = function(client, bufnr)
        -- Remove syntax from LSP
        client.server_capabilities.semanticTokensProvider = nil
    end,
}
-- Define setup for ltex-ls
local ltex_setup = {
    settings = {
        ltex = {
            language = "en-US",
        },
    },
}
-- For ltex-ls under archlinux I have to use the system installation, but
-- for other systems (e.g. Ubuntu) the default cmd works good.
if Path:new("/usr/bin/ltex-ls"):is_file() then
    ltex_setup["cmd"] = { "/usr/bin/ltex-ls" }
end
lspconfig.ltex.setup(ltex_setup)
lspconfig.fortls.setup {}

-- Define formatting for different filetypes
lspconfig.efm.setup {
    flags = {
        debounce_text_changes = 150,
    },
    init_options = { documentFormatting = true },
    filetypes = { "python", "bib" },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            python = {
                { formatCommand = "yapf", formatStdin = true }
            },
            bib = {
                {
                    formatCommand = "bibtex-tidy --v2 --curly --align=14 --no-escape --sort-fields --sort",
                    formatStdin = true
                }
            },
        }
    }
}

-- Autocompletion
local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

-- Define mappings for cmp
local cmp_mappings = {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
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
            cmp_ultisnips_mappings.jump_forwards(fallback)
        end,
        { "i", "s" }
    ),
    ["<C-z>"] = cmp.mapping(
        function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
        end,
        { "i", "s" }
    ),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
    sources = {
        { name = "nvim_lsp",  priority = 0 },
        { name = "path",      priority = 2 },
        { name = "ultisnips", priority = 2 },
        { name = 'buffer',    keyword_length = 3 },
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
            winhighlight = "Normal:CmpNormal",
            border = border,
        },
        documentation = {
            border = border,
            winhighlight = 'Normal:' .. p.gold,
        }
    }
}

cmp.setup(cmp_config)

-- Don't show diagnostics in-line
vim.diagnostic.config({ virtual_text = false })

-- Increase update frequency of the ui
vim.opt.updatetime = 500

-- Show diagnostic in floating window when cursor is hold over the error.
local group_diagnostic = vim.api.nvim_create_augroup("diagnostic", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = { "*" },
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
    group = group_diagnostic
})
