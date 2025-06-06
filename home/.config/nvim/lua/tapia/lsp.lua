local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

--- Python configuration
vim.lsp.config.basedpyright = {
  cmd = { mason_path .. "bin/basedpyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml" },
  filetypes = { "python" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      venvPath = ".venv",
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        autoImportCompletions = false,
        typeCheckingMode = "basic",
      },
    },
  },
}

vim.lsp.config.ruff = {
  cmd = { mason_path .. "bin/ruff", "server" },
  root_markers = { "pyproject.toml" },
  filetypes = { "python" },
  settings = {
    showSyntaxErrors = false,
  },
}

--- Clangd
vim.lsp.config.clangd = {
  cmd = { "clangd", "--background-index" },
  root_markers = { "compile_commands.json", "compile_flags.txt" },
  filetypes = { "c", "cpp" },
}

--- Lua_ls
vim.lsp.config.lua_ls = {
  cmd = { mason_path .. "bin/lua-language-server" },
  root_markers = { "compile_commands.json", "compile_flags.txt" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      -- Disable telemetry
      telemetry = { enable = false },
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          -- Make the server aware of Neovim runtime files
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("config") .. "/lua",
        },
      },
    },
  },
}

--- Rust
vim.lsp.config.rust_analyzer = {
  cmd = { mason_path .. "bin/rust-analyzer" },
  root_markers = { "Cargo.toml" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
}

--- Typst
vim.lsp.config.tinymist = {
  cmd = { mason_path .. "bin/tinymist" },
  filetypes = { "typst" },
  settings = {
    exportPdf = "never",
    semanticTokens = "disable",
  },
}

--- Julia
vim.lsp.config.julials = {
  cmd = { "julia", "--startup-file=no", "--history-file=no", "-e" },
  filetypes = { "julia" },
}

--- Arduino
vim.lsp.config.arduino_language_server = {
  cmd = { mason_path .. "bin/arduino-language-server" },
  filetypes = { "arduino" },
  root_markers = { "sketch.yaml" },
}

--- Taplo (toml files)
vim.lsp.config.taplo = {
  cmd = { mason_path .. "bin/taplo", "lsp", "stdio" },
  filetypes = { "toml" },
}

--- docker-compose
vim.lsp.config.docker_compose_langserver = {
  cmd = { mason_path .. "bin/docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose" },
}

--- docker language server
vim.lsp.config.dockerls = {
  cmd = { mason_path .. "bin/docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
}

--- CSS language server
vim.lsp.config.cssls = {
  cmd = { mason_path .. "bin/vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
}

local language_id_mapping = {
  bib = "bibtex",
  pandoc = "markdown",
  plaintex = "tex",
  mail = "tex",
  rnoweb = "rsweave",
  rst = "restructuredtext",
  tex = "latex",
  text = "plaintext",
}

local function get_language_id(_, filetype)
  return language_id_mapping[filetype] or filetype
end

--- Ltex-plus (grammar check)
vim.lsp.config.ltex_plus = {
  cmd = { "ltex-ls-plus" },
  filetypes = { "markdown", "plaintex", "rst", "tex", "pandoc", "typst", "mail" },
  get_language_id = get_language_id,
  settings = {
    ltex = {
      language = "en-US",
    },
  },
}

--- json language serven
vim.lsp.config.jsonls = {
  cmd = { mason_path .. "bin/vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
}

--- HTML language serven
vim.lsp.config.html = {
  cmd = { mason_path .. "bin/vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}

vim.lsp.enable({
  "basedpyright",
  "ruff",
  "clangd",
  "lua_ls",
  "rust_analyzer",
  "tinymist",
  "julials",
  "arduino_language_server",
  "docker_compose_langserver",
  "dockerls",
  "cssls",
  "ltex_plus",
  "jsonls",
  "html",
})

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_lines = false,
  virtual_text = false,
  severity_sort = true,
})

vim.lsp.inlay_hint.enable(false)
