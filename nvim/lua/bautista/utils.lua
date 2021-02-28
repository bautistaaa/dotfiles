local M = {}

M.key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

function ReloadConfig()
  print('Reloading config')
  require'plenary.reload'.reload_module('bautista')
end

return M

