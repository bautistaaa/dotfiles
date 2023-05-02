local user_plugins = {
	-- Core
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<Leader>g", "<Cmd>Git<CR>", { desc = "Git status" })
		end,
	},
	"tpope/vim-surround",
	"numToStr/Comment.nvim",
	-- This allows for JSX comments
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	},
	"tpope/vim-repeat",
	"tpope/vim-rhubarb",
	"janko/vim-test",
	"jiangmiao/auto-pairs",
	"mattn/emmet-vim",
	{
		"github/copilot.vim",
		config = function()
			require("trash.plugins.configs.copilot")
		end,
	},
	"kevinhwang91/nvim-bqf",
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<Leader>u", "<Cmd>UndotreeToggle<CR>", { desc = "Open undo tree" })
		end,
	},

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("trash.plugins.configs.neo-tree")
		end,
	},

	-- Telescope
	{
		"nvim-lua/telescope.nvim",
		branch = "0.1.x",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("trash.plugins.configs.telescope")
		end,
	},

	-- Whichkey
	{
		"folke/which-key.nvim",
		config = function()
			require("trash.plugins.configs.which-key")
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		requires = {
			-- Debuggers
			"mfussenegger/nvim-dap",
			-- Linter/Formatter
			"creativenull/diagnosticls-configs-nvim",
			-- Tool installer
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"jayp0521/mason-nvim-dap.nvim",
			-- Rust specific
			"simrat39/rust-tools.nvim",
		},
		config = function()
			require("mason").setup()

			-- LSP
			require("trash.plugins.configs.lspconfig")

			-- Debugger
			require("trash.plugins.configs.dap")
		end,
	},

	-- Autocompletion and Snippets
	{
		"hrsh7th/nvim-cmp",
		requires = {
			-- Cmdline completions
			"hrsh7th/cmp-cmdline",
			-- Path completions
			"hrsh7th/cmp-path",
			-- Buffer completions
			"hrsh7th/cmp-buffer",
			-- LSP completions
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind-nvim",
			-- vnsip completions
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("trash.plugins.configs.cmp")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("trash.plugins.configs.treesitter")
		end,
	},

	-- sourcegraph
	{
		"sourcegraph/sg.nvim",
		run = "cargo build --workspace",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- Theme/Syntax
	{
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("trash.plugins.configs.ufo")
		end,
	},
	{ "catppuccin/nvim", as = "catppuccin" },
	{
		"akinsho/bufferline.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trash.plugins.configs.bufferline")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trash.plugins.configs.lualine")
		end,
	},
	"princejoogie/tailwind-highlight.nvim",
}

-- Plugin Setup
-- ============
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").init({
	compile_path = string.format("%s/site/plugin/packer_compiled.lua", vim.fn.stdpath("data")),
	display = {
		prompt_border = "rounded",
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- My plugins here
	for _, user_plugin in pairs(user_plugins) do
		use(user_plugin)
	end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
