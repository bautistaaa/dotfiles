local M = {}

local function init()
	-- Enable provider for only python3 and node
	vim.g.python3_host_prog = vim.fn.exepath("python3")
	vim.g.loaded_python_provider = 0
	vim.g.loaded_perl_provider = 0
	vim.g.loaded_ruby_provider = 0

	vim.g.github_enterprise_urls = { "https://github.prod.hulu.com" }
	vim.g["test#strategy"] = "neovim"
	vim.g["test#neovim#term_position"] = "vertical"
	vim.g["test#javascript#jest#options"] = "--watch"
end

function M.setup()
	init()

	require("trash.autocmds")
	require("trash.keymaps")
	require("trash.options")
	require("trash.plugins")
	require("trash.colorscheme")
end

return M
