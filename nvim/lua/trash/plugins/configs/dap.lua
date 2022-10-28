vim.keymap.set("n", "<F5>", [[<Cmd>lua require'dap'.continue()<CR>]])
vim.keymap.set("n", "<F10>", [[<Cmd>lua require'dap'.step_over()<CR>]])
vim.keymap.set("n", "<F11>", [[<Cmd>lua require'dap'.step_into()<CR>]])
vim.keymap.set("n", "<F12>", [[<Cmd>lua require'dap'.step_out()<CR>]])
vim.keymap.set("n", "<Leader>b", [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]])
vim.keymap.set("n", "<Leader>B", [[<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]])
vim.keymap.set(
	"n",
	"<Leader>lp",
	[[<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]]
)
vim.keymap.set("n", "<Leader>dr", [[<Cmd>lua require'dap'.repl.open()<CR>]])
vim.keymap.set("n", "<Leader>dl", [[<Cmd>lua require'dap'.run_last()<CR>]])
