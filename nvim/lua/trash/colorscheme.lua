local catppuccin = require("catppuccin")

if not catppuccin then
	return
end

vim.g.catppuccin_flavour = "mocha"

catppuccin.setup()

vim.cmd([[colorscheme catppuccin]])
