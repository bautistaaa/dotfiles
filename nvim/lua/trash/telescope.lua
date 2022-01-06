local telescope = require 'telescope'
local telescope_actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/", "coverage/", "__pycache__/", "%.o" },
    mappings = {
      i = {
        ['<C-k>'] = telescope_actions.move_selection_previous,
        ['<C-j>'] = telescope_actions.move_selection_next
      }
    }
  }
}
