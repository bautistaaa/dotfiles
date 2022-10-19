local M = {}

---Reload the config that is namespaced, eg ~/.config/nvim/lua/{ns}
---will be removed from cache and re-loaded when dofile() is called
---@param ns string
---@return nil
function M.reload_config(ns)
	ns = ns or "trash"

	for name, _ in pairs(package.loaded) do
		if name:match("^" .. ns) then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)

	vim.cmd("PackerCompile")
end

return M
