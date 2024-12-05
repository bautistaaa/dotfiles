require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "css",
    "graphql",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "python",
    "rust",
    "svelte",
    "tsx",
    "typescript",
    "prisma",
  },
  highlight = { enable = true },
})
