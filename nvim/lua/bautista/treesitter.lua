local configs = require'nvim-treesitter.configs'

configs.setup {
  ensure_installed = {
    'html',
    'css',
    'json',
    'javascript',
    'typescript',
    'python',
    'lua',
    'tsx'
  },
  highlight = {
    enable = true
  }
}

