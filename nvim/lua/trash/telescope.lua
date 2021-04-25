  local telescope = require 'telescope'
  local telescope_actions = require 'telescope.actions'
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-k>'] = telescope_actions.move_selection_previous,
          ['<C-j>'] = telescope_actions.move_selection_next
        }
      }
    }
  }

