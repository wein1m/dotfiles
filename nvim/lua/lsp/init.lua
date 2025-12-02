-- Load lspconfig to add server configs to Neovim's runtime path
-- This makes server configurations available to vim.lsp.config()
require('lspconfig')

local setup_buffer = require("lsp/buffer_setup")

-- {{{ LspAttach autocmd - replaces on_attach
-- This is the new Neovim 0.11+ way to handle LSP buffer setup
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then return end

    require('lsp_signature').on_attach(
      { doc_lines = 5, hint_prefix = "<>", handler_opts = { border = 'rounded' } },
      bufnr
    )

    setup_buffer.setup_lsp_keymaps(client, bufnr)
    setup_buffer.setup_diagnostics_keymaps(client, bufnr)
    setup_buffer.setup_formatting_keymaps(client, bufnr)
    setup_buffer.setup_commands(client, bufnr)

    setup_buffer.setup_autocmds(client, bufnr)
    setup_buffer.setup_options(client, bufnr)
  end,
})
-- }}}

-- {{{ pyright setup
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'off',
        diagnosticMode = 'workspace',
        autoSearchPaths = true,
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
      }
    }
  },
})
-- }}}

-- {{{ clangd setup
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    semanticHighlighting = true
  },
})
-- }}}

-- {{{ lua_ls setup
-- vim runtime files
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = runtime_path },
      diagnostics = { globals = { "vim", "use", "packer_plugins", "require", "session" } },
      telemetry = { enable = false },
      hint = { enable = true },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file('', true),
          -- vim.fn.stdpath('config'),
          -- vim.fn.stdpath('config') .. '/lua',
        },
        maxPreload = 1000,
        preloadFileSize = 150
      }
    }
  },
})
-- }}}

-- {{{ efm-ls setup
local clike = {
  require('efmls-configs.linters.cpplint'),
}
local languages = {
  python = { require('efmls-configs.formatters.autopep8'), },
  markdown = { require('efmls-configs.formatters.prettier'), },

  -- c = {
  --   {
  --     formatCommand = "clang-format --assume-filename='${INPUT}'",
  --     formatStdin = true,
  --   },
  -- },
  -- cpp = {
  --   {
  --     formatCommand = "clang-format --assume-filename='${INPUT}'",
  --     formatStdin = true,
  --   },
  -- },
  c = vim.tbl_deep_extend('force', clike, {}),
  cpp = vim.tbl_deep_extend('force', clike, {}),
  cuda = vim.tbl_deep_extend('force', clike, {}),
}

vim.lsp.config('efm', {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
})
-- }}}

-- {{{ null-ls setup
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.completion.spell.with({ filetypes = { 'text', 'markdown' } }),
    null_ls.builtins.formatting.shfmt.with({ filetypes = { 'sh', 'bash' } })
  },
})
-- }}}

-- {{{ Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.lua", "*.py" },
  callback = function()
    vim.lsp.buf.format()
  end
})
-- }}}

-- {{{ Enable all LSP servers
vim.lsp.enable({
  'pyright',
  'clangd',
  'lua_ls',
  'efm',
})
-- }}}
