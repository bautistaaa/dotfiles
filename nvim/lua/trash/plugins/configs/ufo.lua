local ufo = require("ufo")

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = -1
vim.o.foldenable = true

ufo.setup({
	provider_selector = function()
		return { "treesitter", "indent" }
	end,
})

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
