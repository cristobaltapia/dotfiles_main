local lsp = require('lsp-zero').preset({})

require("neodev").setup()

-- Configure lua language server for neovim
local nvim_lsp = require('lspconfig')

-- Configure all the other language servers
nvim_lsp.lua_ls.setup(lsp.nvim_lua_ls())
nvim_lsp.pyright.setup {}
nvim_lsp.typst_lsp.setup { single_file_support = true }
nvim_lsp.julials.setup {}
nvim_lsp.texlab.setup {}
nvim_lsp.docker_compose_language_service.setup {}
-- Remove syntax from LSP
nvim_lsp.dockerls.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
    end,
}
nvim_lsp.ltex.setup {
    cmd = { "/usr/bin/ltex-ls" },
    settings = {
        ltex = {
            language = "en-US",
        },
    },
}

-- Define formatting for different filetypes
nvim_lsp.efm.setup {
    flags = {
        debounce_text_changes = 150,
    },
    init_options = { documentFormatting = true },
    filetypes = { "python" },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            python = {
                { formatCommand = "yapf", formatStdin = true }
            },
        }
    }
}

-- Configure suggestions menu
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Insert }
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-Space>'] = cmp.mapping.confirm({ select = true, behavior = 'replace' }),
    -- ['<C-Space>'] = cmp.mapping.complete(cmp_select),
    ["<C-k>"] = cmp.mapping(
        function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
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
})

-- Add parenthesis automatically after functions
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

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

-- Setup nvim-cmp
lsp.setup_nvim_cmp({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    sources = {
        { name = "ultisnips",               priority = 2 },
        { name = "nvim_lsp",                priority = 1 },
        { name = "nvim_lsp_signature_help", priority = 0 },
        { name = "path",                    priority = 2 },
    },
    mapping = cmp_mappings,
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    experimental = {
        ghost_text = true
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
})

-- Ensure the installation of the following language servers
lsp.ensure_installed({
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
})

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

-- Bindings for different actions related to the LSP
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    local opts = { buffer = bufnr, remap = false }
    -- Format code
    vim.keymap.set({ 'n', 'x' }, 'gq', function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end, opts)
    -- Go to definition
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    -- Show information of element below the cursor
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
