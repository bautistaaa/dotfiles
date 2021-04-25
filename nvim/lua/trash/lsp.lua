local lspconfig = require'lspconfig'

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = { severity_limit = "Error" },
    signs = true,
    update_in_insert = false,
  }
)

local function lsp_map(mode, left_side, right_side)
  vim.api.nvim_buf_set_keymap(0, mode, left_side, right_side, {noremap=true})
end

local function default_on_attach(client)
  print('Attaching to ' .. client.name)

  lsp_map('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>')
  lsp_map('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>')
  lsp_map('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
  lsp_map('n', 'gw',         '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  lsp_map('n', 'gW',         '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  lsp_map('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  lsp_map('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  lsp_map('n', '<c-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  -- lsp_map('n', '<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  --  see lspsaga for alternative
  -- lsp_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  lsp_map('n', '<leader>p',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
  lsp_map('n', '<leader>le', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

end

local default_config = {
  on_attach = default_on_attach,
}

local pid = vim.fn.getpid()
local cache_path = vim.fn.stdpath('cache')
--
-- Language Servers
lspconfig.pyls.setup(default_config)
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.tsserver.setup(default_config)
lspconfig.vimls.setup(default_config)
lspconfig.yamlls.setup(default_config)

