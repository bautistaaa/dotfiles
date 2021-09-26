local utils = require 'trash.utils'

local saga = require 'lspsaga'
saga.init_lsp_saga {
  code_action_prompt = { enable = true }
}

utils.key_mapper('n', 'K',          '<cmd>Lspsaga hover_doc<CR>')
utils.key_mapper('n', '<c-k>',      '<cmd>Lspsaga signature_help<CR>')
utils.key_mapper('n', '<leader>af', '<cmd>Lspsaga code_action<CR>')
utils.key_mapper('n', '<leader>rn', '<cmd>Lspsaga rename<CR>')
utils.key_mapper('n', '<leader>ls', '<cmd>Lspsaga show_line_diagnostics<CR>')
