require("neodev").setup()
local lspconfig = require("lspconfig")
local diagnosticls = require("diagnosticls-configs")
local format_group = vim.api.nvim_create_augroup("LspFormatGroup", {})
local format_opts = { async = false, timeout_ms = 500 }

local function register_fmt_keymap(name, bufnr)
	vim.keymap.set("n", "<leader>p", function()
		vim.lsp.buf.format(vim.tbl_extend("force", format_opts, { name = name, bufnr = bufnr }))
	end, { desc = "Format current buffer [LSP]", buffer = bufnr })
end

local function register_fmt_autosave(name, bufnr)
	vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = format_group,
		buffer = bufnr,
		callback = function()
			vim.print("Formatting...")
			vim.lsp.buf.format(vim.tbl_extend("force", format_opts, { name = name, bufnr = bufnr }))
		end,
		desc = "Format on save [LSP]",
	})
end

-- Global diagnostic config
vim.diagnostic.config({
	underline = { severity_limit = "Error" },
	signs = true,
	update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

local function on_attach(client, bufnr)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition [LSP]", buffer = bufnr })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = bufnr })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration [LSP]", buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implentation [LSP]", buffer = bufnr })
	vim.keymap.set("n", "gw", vim.lsp.buf.document_symbol, { desc = "Search document symbols [LSP]", buffer = bufnr })
	vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { desc = "Search workspace symbols [LSP]", buffer = bufnr })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references [LSP]", buffer = bufnr })
	vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, { desc = "Show signature help [LSP]", buffer = bufnr })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show stuff on hover", buffer = bufnr })
	vim.keymap.set("n", "<leader>af", vim.lsp.buf.code_action, { desc = "Code action [LSP]", buffer = bufnr })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename [LSP]", buffer = bufnr })
	vim.keymap.set(
		"n",
		"<leader>ls",
		vim.diagnostic.open_float,
		{ desc = "Show diagnostic at line [LSP]", buffer = bufnr }
	)

	if client.name == "tsserver" then
		vim.keymap.set(
			"n",
			"<Leader>oi",
			"<Cmd>OrganizeImports<CR>",
			{ desc = "Organize imports [TS]", buffer = bufnr }
		)
	end

	if client.name == "rust_analyzer" then
		register_fmt_keymap(client.name, bufnr)
		register_fmt_autosave(client.name, bufnr)
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

local default_config = {
	on_attach = on_attach,
	capabilities = capabilities,
}

require("mason-tool-installer").setup({
	ensure_installed = {
		"eslint_d",
		"prettier",
		"stylua",
		"codelldb",
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"cssls",
		"diagnosticls",
		"dockerls",
		"gopls",
		"html",
		"jsonls",
		"pylsp",
		"rust_analyzer",
		"lua_ls",
		"tailwindcss",
		"tsserver",
		"yamlls",
	},
	automatic_installation = true,
})

-- Language Servers
lspconfig.pylsp.setup(default_config)
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.yamlls.setup(default_config)
lspconfig.gopls.setup(default_config)

-- Tailwind CSS
local tw_highlight = require("tailwind-highlight")
lspconfig.tailwindcss.setup({
	on_attach = function(client, bufnr)
		tw_highlight.setup(client, bufnr, {
			single_column = false,
			mode = "background",
			debounce = 200,
		})

		on_attach(client, bufnr)
	end,
})

-- Typescript/JavaScript
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

-- Lua
local lua_rtp = vim.split(package.path, ";")
table.insert(lua_rtp, "lua/?.lua")
table.insert(lua_rtp, "lua/?/init.lua")
lspconfig.lua_ls.setup(vim.tbl_extend("force", default_config, {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}))

diagnosticls.init({
	on_attach = function(_, bufnr)
		register_fmt_keymap("diagnosticls", bufnr)
		register_fmt_autosave("diagnosticls", bufnr)
	end,
})

local web_configs = {
	linter = require("diagnosticls-configs.linters.eslint_d"),
	formatter = require("diagnosticls-configs.formatters.prettier"),
}

diagnosticls.setup({
	javascript = web_configs,
	javascriptreact = web_configs,
	typescript = web_configs,
	typescriptreact = web_configs,
	lua = {
		formatter = require("diagnosticls-configs.formatters.stylua"),
	},
})

-- Rust
require("rust-tools").setup({
	server = default_config,
})
