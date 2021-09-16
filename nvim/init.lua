vim.g.python3_host_prog = '/usr/local/bin/python3'
-- ====================================================================================
-- Autocmds
-- ====================================================================================

vim.cmd 'augroup colorscheme_opts'
vim.cmd 'au!'
vim.cmd 'au ColorScheme * hi! Normal guibg=NONE'
vim.cmd 'au ColorScheme * hi! SignColumn guibg=NONE'
vim.cmd 'au ColorScheme * hi! CursorColumn guibg=#404040'
vim.cmd 'au ColorScheme * hi! CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow'
vim.cmd 'au ColorScheme * hi! LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE'
vim.cmd 'augroup END'
vim.cmd 'colorscheme onedark'

-- ====================================================================================
-- Theme
-- ====================================================================================

vim.g.mapleader = ' '

vim.o.termguicolors = true
vim.wo.relativenumber = true
vim.o.relativenumber = true

vim.g.github_enterprise_urls = { 'https://github.prod.hulu.com' }
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vertical'
vim.g['test#javascript#jest#options'] = '--watch'

-- ====================================================================================
-- Options
-- ====================================================================================

vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = true
vim.wo.cursorcolumn = true
vim.o.list = true
vim.wo.number = true
vim.wo.numberwidth = 2
vim.o.laststatus = 2
vim.o.scrolloff = 5
vim.o.showtabline = 2

require'trash'
