-- vim.keymap.set(
-- 	"i",
-- 	"<C-j>",
-- 	'copilot#Accept("<CR>")',
-- 	{ silent = true, script = true, expr = true, desc = "Accept the current suggestion shown" }
-- )
-- vim.g.copilot_no_tab_map = true

vim.cmd([[
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
]])
