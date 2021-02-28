local o=vim.o
local bo=vim.bo
local wo=vim.wo

o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
bo.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
bo.autoindent = true
bo.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.wrap = false

wo.cursorcolumn = true
o.list = true
o.number = true
wo.numberwidth = 2
o.laststatus = 2

vim.g.airline_theme='base16'
vim.g.github_enterprise_urls = {'https://github.prod.hulu.com'}
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#bufferline#enabled'] = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_min_count'] = 2
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
vim.g.airline_section_y=''
vim.g.airline_skip_empty_sections = 1
vim.g.mapleader = ' '

require'bautista'
