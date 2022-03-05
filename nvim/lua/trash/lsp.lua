local lspconfig = require 'lspconfig'

-- Global diagnostic config
vim.diagnostic.config({
  underline = { severity_limit = "Error" },
  signs = true,
  update_in_insert = false,
})

-- Add border like lspsaga
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  width = 80,
  border = 'single',
})

-- Add border like lspsaga
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = 'single',
})

-- Code action popup
-- but only use it if installed
local success_lsputils, lsputils_codeAction = pcall(require, 'lsputil.codeAction')
if success_lsputils then
  if vim.fn.has('nvim-0.6') == 1 then
    vim.lsp.handlers['textDocument/codeAction'] = lsputils_codeAction.code_action_handler
  else
    vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
      lsputils_codeAction.code_action_handler(nil, actions, nil, nil, nil)
    end
  end
end

local function lsp_map(mode, left_side, right_side)
  vim.api.nvim_buf_set_keymap(vim.api.nvim_get_current_buf(), mode, left_side, right_side, { noremap = true })
end

local function on_attach(client, bufnr)
  print('Attaching to ' .. client.name)

  lsp_map('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>')
  lsp_map('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>')
  lsp_map('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
  lsp_map('n', 'gw',         '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  lsp_map('n', 'gW',         '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  lsp_map('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  lsp_map('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  lsp_map('n', '<leader>le', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  lsp_map('n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>')

  -- Replacement for lspsaga
  lsp_map('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
  lsp_map('n', '<c-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  lsp_map('n', '<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  lsp_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  local diag_opts = '{ width = 80, focusable = false, border = "single" }'
  lsp_map(
    'n',
    '<leader>ls',
    string.format('<cmd>lua vim.diagnostic.open_float(%d, %s)<CR>', bufnr, diag_opts)
  )

  -- disable formatting from tsserver
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Only load cmp lsp capabilities when avaiabled
-- in case you uninstall nvim-cmp
local success_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if success_cmp_lsp then
  capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local default_config = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Language Servers
-- lspconfig.pyls.setup(default_config)
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.tsserver.setup(default_config)
lspconfig.vimls.setup(default_config)
lspconfig.yamlls.setup(default_config)

-- local efm = require('efmls-configs')
-- efm.init(vim.tbl_extend('force', default_config, {
--   init_options = {
--     documentFormatting = true, -- enable formatting
--   },
-- }))
-- efm.setup({
--   javascript = {
--     linter = require('efmls-configs.linters.eslint'),
--     formatter = require('efmls-configs.formatters.prettier'),
--   },
--   javascriptreact = {
--     linter = require('efmls-configs.linters.eslint'),
--     formatter = require('efmls-configs.formatters.prettier'),
--   },
--   typescript = {
--     linter = require('efmls-configs.linters.eslint'),
--     formatter = require('efmls-configs.formatters.prettier'),
--   },
--   typescriptreact = {
--     linter = require('efmls-configs.linters.eslint'),
--     formatter = require('efmls-configs.formatters.prettier'),
--   },
-- })

local nls = require('null-ls')
nls.setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.prettier,
    require("null-ls").builtins.diagnostics.eslint,
  },
})

-- Lua language server
local root_pattern = require 'lspconfig'.util.root_pattern

local lua_rtp = vim.split(package.path, ';')
table.insert(lua_rtp, 'lua/?.lua')
table.insert(lua_rtp, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup(vim.tbl_extend('force', default_config, {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = lua_rtp,
      },
      diagnostics = { globals = {'vim'} },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
  root_dir = root_pattern('.luals'),
}))
