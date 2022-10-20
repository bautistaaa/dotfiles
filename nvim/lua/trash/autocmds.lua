-- Transparent highlights
local function transparent_cb()
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#404040" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "Yellow", bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", fg = "DarkGrey", bold = false, underline = false, italic = false })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "#eeeeee" })
	vim.api.nvim_set_hl(0, "ErrorFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "WarningFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "InfoFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "HintFloat", { bg = "NONE" })
end

local transparent_group = vim.api.nvim_create_augroup("TransparentGroup", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = transparent_group,
	callback = transparent_cb,
	desc = "Transparent highlights",
})

-- Briefly highlight code on yank
local yank_group = vim.api.nvim_create_augroup("YankGroup", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
	desc = "Briefly highlight code on yank",
})
