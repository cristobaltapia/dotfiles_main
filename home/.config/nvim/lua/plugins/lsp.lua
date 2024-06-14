return {
  -- Lsp-connfig
  {
    'neovim/nvim-lspconfig',
    name = "nvim-lspconfig",
    dependencies = {
      { "folke/lazydev.nvim" },
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
      inlay_hints = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = false,
    },
    config = function(_, opts)
      local Path = require("plenary.path")
      -- require("lazydev").setup { lspconfig = true, }

      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )
      -- lsp_defaults.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

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
          -- Formatting is done with conform.nvim
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
          'basedpyright',
          'bashls',
          'clangd',
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
          'ruff',
          'rust_analyzer',
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
              -- path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                -- Make the server aware of Neovim runtime files
                vim.env.VIMRUNTIME,
                vim.fn.stdpath('config') .. '/lua'
              }
            }
          }
        }
      }
      -- Rust
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = true,
            }
          }
        }
      }

      -- Clangd
      lspconfig.clangd.setup {}

      -- Python LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

      lspconfig.basedpyright.setup {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'workspace',
              useLibraryCodeForTypes = true,
              autoImportCompletions = false,
              typeCheckingMode = 'basic',
            }
          }
        }
      }

      lspconfig.ruff.setup {}

      -- Typst
      lspconfig.typst_lsp.setup {
        single_file_support = true,
        settings = {
          exportPdf = "never"
        }
      }

      -- Julia
      -- local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
      lspconfig.julials.setup {
        cmd = { 'julia', "--project=." },
        -- on_new_config = function(new_config, _)
        --   local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        --   if require 'lspconfig'.util.path.is_file(julia) then
        --     new_config.cmd[1] = julia
        --   end
        -- end
      }

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
      lspconfig.cssls.setup {}
      -- Grammar correctoin using ltex-ls
      local ltex_setup = {
        filetypes = { "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc",
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
      lspconfig.jsonls.setup {
        init_options = {
          provideFormatter = false
        }
      }
      -- HTML
      lspconfig.html.setup {}

      -- Don't show diagnostics in-line
      vim.diagnostic.config({ virtual_text = false })

      -- Increase update frequency of the ui
      vim.opt.updatetime = 500
    end
  },
  {
    "folke/lazydev.nvim",
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
  -- Conform: formatting
  {
    'stevearc/conform.nvim',
    opts = {},
    dependencies = {
      "mason",
      "nvim-lspconfig",
    },
    config = function(_, opts)
      local conform = require('conform')
      -- local mason = require('mason')
      -- local mason_registry = require('mason-registry')

      vim.keymap.set("n", "gq", function() conform.format({}) end)

      conform.setup({
        lsp_fallback = true,
        formatters = {
          findent = {
            args = { "--continuation", "0", "--input_format", "fixed", "--indent_procedure", "0" }
          },
          ["bibtex-tidy"] = {
            args = { "--v2", "--curly", "--align", "14", "--no-escape", "--sort-fields", "--sort" }
          }
        },
        formatters_by_ft = {
          python = { "isort", "ruff_format" },
          bib = { "bibtex-tidy" },
          rust = { "rustfmt" },
          typst = { "typstfmt" },
          tex = { "latexindent" },
          cls = { "latexindent" },
          sty = { "latexindent" },
          fortran = { "findent" },
          css = { "prettier" },
          scss = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
        }
      })
    end
  },
  -- Function signatures
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function(_, opts)
      require 'lsp_signature'.setup(opts)
    end,
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
