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
        map('n', 'ge', vim.diagnostic.open_float)
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

require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'tsserver',
        'eslint',
        'pyright',
        'ltex',
        'texlab',
        'julials',
        'cssls',
        'efm',
        'marksman',
        'typst_lsp',
        'docker_compose_language_service',
        'dockerls',
        'fortls',
        'bashls',
        'ruff_lsp',
        'taplo',
        'jsonls',
    }
})

-- Configure Lua-ls
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

-- Python LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
lspconfig.pyright.setup {}
lspconfig.ruff_lsp.setup {}
-- Typst
lspconfig.typst_lsp.setup { single_file_support = true }
-- Julia
lspconfig.julials.setup {}
-- Latex
lspconfig.texlab.setup {}
-- Toml
lspconfig.taplo.setup {}
-- Docker
lspconfig.docker_compose_language_service.setup {}
lspconfig.dockerls.setup {
    on_attach = function(client, bufnr)
        -- Remove syntax from LSP
        client.server_capabilities.semanticTokensProvider = nil
    end,
}
-- Grammar correctoin using ltex-ls
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
-- JSON-ls
lspconfig.jsonls.setup {}

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


-- Don't show diagnostics in-line
vim.diagnostic.config({ virtual_text = false })

-- Increase update frequency of the ui
vim.opt.updatetime = 500
