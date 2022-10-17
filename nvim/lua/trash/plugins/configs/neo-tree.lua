-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	close_if_last_window = true,
})

vim.keymap.set("n", "<Leader>tt", "<Cmd>Neotree reveal toggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<Leader>tc", "<Cmd>Neotree action=close source=filesystem<CR>", { desc = "Close file tree" })
vim.keymap.set("n", "<Leader>tf", "<Cmd>Neotree reveal action=focus<CR>", { desc = "Focus file tree" })
