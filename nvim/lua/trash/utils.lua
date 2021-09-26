local M = {}

M.key_mapper = function(mode, lhs, rhs, opts)
  local def_opts = { noremap = true, silent = true }
  if opts == nil then
    opts = {}
  end

  local keyopts = vim.tbl_extend('force', def_opts, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, keyopts)
end

M.reload_config = function()
  for name,_ in pairs(package.loaded) do
    if name:match('^trash') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

return M
