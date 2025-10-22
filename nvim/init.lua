require("tgk")

-- ─────────────────────────────────────────────────────────────
-- 🔸 LSP Mappings + Settings
-- ─────────────────────────────────────────────────────────────
local opts = { noremap = true, silent = true }

-- Diagnostic mappings
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- ─────────────────────────────────────────────────────────────
-- 🔸 on_attach: Set buffer-local mappings when LSP attaches
-- ─────────────────────────────────────────────────────────────
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- ─────────────────────────────────────────────────────────────
-- 🔸 Capabilities
-- ─────────────────────────────────────────────────────────────
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- ─────────────────────────────────────────────────────────────
-- 🔸 Configure & Enable LSP servers
-- ─────────────────────────────────────────────────────────────

-- Lua LSP (special case)
vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable('lua_ls')

-- Common LSP servers
local servers = {
  'tailwindcss',
  'ts_ls',
  'jsonls',
  'eslint',
  'cssls',
  'html',
}

for _, server in ipairs(servers) do
  -- You can add per-server tweaks here if needed
  vim.lsp.config(server, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(server)
end

-- Example: extra settings for ts_ls (JSX)
vim.lsp.config('ts_ls', vim.tbl_deep_extend('force', {
  on_attach = on_attach,
  capabilities = capabilities,
}, {
  settings = {
    typescript = { jsxEnabled = true },
    javascript = { jsxEnabled = true },
  }
}))
vim.lsp.enable('ts_ls')

