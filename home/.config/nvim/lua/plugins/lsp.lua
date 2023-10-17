return {
  -- Lsp-connfig
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { "folke/neodev.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "ray-x/lsp_signature.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns
          -- the diagnostics icon based on the severity this only
          -- works on a recent 0.10.0 build. Will be set to "●" when
          -- not supported prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >=
      -- 0.10.0 Be aware that you also will need to properly configure
      -- your LSP server to provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = false,
    },
    config = function(_, opts)
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
            local options = { buffer = bufnr, remap = false }
            vim.keymap.set(m, lhs, rhs, options)
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

      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'cssls',
          'docker_compose_language_service',
          'dockerls',
          'efm',
          'eslint',
          'fortls',
          'html',
          'jsonls',
          'julials',
          'ltex',
          'lua_ls',
          'marksman',
          'pyright',
          'ruff_lsp',
          'taplo',
          'tsserver',
          'typst_lsp',
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
      lspconfig.pyright.setup {
        -- cmd = {"pyright-langserver", "--stdio", "--project", vim.env.HOME .. "/.config/pyright.json"},
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              disableOrganizeImports = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
              autoImportCompletions = false,
            }
          }
        }
      }
      lspconfig.ruff_lsp.setup {}
      -- Typst
      lspconfig.typst_lsp.setup {
        single_file_support = true,
        settings = {
          exportPdf = "never"
        }
      }
      -- Julia
      lspconfig.julials.setup {}
      -- Latex
      -- lspconfig.texlab.setup {}
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
      -- CSS
      lspconfig.cssls.setup { }
      -- Grammar correctoin using ltex-ls
      local ltex_setup = {
        filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc",
          "typst" },
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
      -- HTML
      lspconfig.html.setup {}

      -- Define formatting for different filetypes
      local texFormatter = 'latexindent --modifylinebreaks -y="defaultIndent: \'  \'"'
      local prettierFormat = {
        formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
        formatStdin = true,
      }
      lspconfig.efm.setup {
        flags = {
          debounce_text_changes = 150,
        },
        init_options = { documentFormatting = true },
        filetypes = { "python", "bib", "tex", "sty", "cls", "fortran", "css", "scss" },
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
            fortran = {
              {
                formatCommand = "findent --continuation=0 --input_format=fixed --indent_procedure=0",
                formatStdin = true
              }
            },
            tex = { { formatCommand = texFormatter, formatStdin = true } },
            sty = { { formatCommand = texFormatter, formatStdin = true } },
            cls = { { formatCommand = texFormatter, formatStdin = true } },
            css = { prettierFormat },
            scss = { prettierFormat },
          }
        }
      }


      -- Don't show diagnostics in-line
      vim.diagnostic.config({ virtual_text = false })

      -- Increase update frequency of the ui
      vim.opt.updatetime = 500
    end
  },
  {
    "folke/neodev.nvim",
    opts = {
      lspconfig = true
    }
  },
  -- Mason
  {
    'williamboman/mason-lspconfig.nvim',
    name = "mason",
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    }
  },
  -- Function signatures
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    opts = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      hint_enable = true,
      doc_lines = 0,
      floating_window = false,
      toggle_key = "<C-h>",
      select_signature_key = "<C-l>",
      floating_window_above_cur_line = true,
      handler_opts = {
        border = "rounded"
      }
    }
  },
}
-- vim: set shiftwidth=2:
