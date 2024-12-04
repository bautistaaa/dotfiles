require("neodev").setup()
local lspconfig = require("lspconfig")
local format_group = vim.api.nvim_create_augroup("LspFormatGroup", {})
local format_opts = { async = false, timeout_ms = 2500 }

local function register_fmt_keymap(name, bufnr)
  vim.keymap.set("n", "<leader>p", function()
    vim.lsp.buf.format(vim.tbl_extend("force", format_opts, { name = name, bufnr = bufnr }))
  end, { desc = "Format current buffer [LSP]", buffer = bufnr })
end

local function fmt_cb(bufnr)
  return function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
      return
    end

    if res then
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("silent noautocmd update")
      end)
    end
  end
end

local function register_fmt_autosave(name, bufnr)
  vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = format_group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        fmt_cb(bufnr)
      )
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
  if client.name == "null-ls" then
    register_fmt_keymap(client.name, bufnr)
    register_fmt_autosave(client.name, bufnr)
    return
  end

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

  if client.name == "ts_ls" then
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
    -- "eslint_d",
    "eslint",
    "prettier",
    "stylua",
    "codelldb",
  },
})
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "pylsp",
    "rust_analyzer",
    "lua_ls",
    "tailwindcss",
    "ts_ls",
    "yamlls",
    "eslint",
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

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})
lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
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

-- null-ls - for linting and formatting using external tools
local null_ls = require("null-ls")

null_ls.setup({
  on_attach = on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    require("none-ls.diagnostics.eslint_d"),
  },
})

-- Rust
require("rust-tools").setup({
  server = default_config,
})
