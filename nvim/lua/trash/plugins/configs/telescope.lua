local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "%.git/", "node_modules/", "coverage/", "__pycache__/", "%.o", "client/graphql/" },
		mappings = {
			i = {
				["<C-k>"] = telescope_actions.move_selection_previous,
				["<C-j>"] = telescope_actions.move_selection_next,
			},
		},
	},
})

vim.keymap.set("n", "<Leader>s", function()
	telescope_builtin.find_files({ hidden = true })
end, { desc = "Find files" })

vim.keymap.set("n", "<Leader>c", function()
	telescope_builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find files within vim config" })

vim.keymap.set("n", "<Leader>f", function()
	telescope_builtin.live_grep()
end, { desc = "Grep files" })

vim.keymap.set("n", "<Leader>fh", function()
	telescope_builtin.help_tags()
end, { desc = "Help tags" })

vim.keymap.set("n", "<Leader>fb", function()
	telescope_builtin.buffers()
end, { desc = "Show buffers" })

vim.keymap.set("n", "<Leader>gs", function()
	telescope_builtin.git_status()
end, { desc = "Git status" })
