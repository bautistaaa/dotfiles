-- ====================================================================================
-- Initialize
-- ====================================================================================

vim.g.mapleader = ' '

-- Enable provider for only python3 and node
vim.g.python3_host_prog = vim.fn.exepath('python3')
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.github_enterprise_urls = { 'https://github.prod.hulu.com' }
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vertical'
vim.g['test#javascript#jest#options'] = '--watch'

-- ====================================================================================
-- Autocmds
-- ====================================================================================

vim.cmd 'augroup colorscheme_opts'
vim.cmd 'au!'
vim.cmd 'au ColorScheme * hi Normal guibg=NONE'
vim.cmd 'au ColorScheme * hi SignColumn guibg=NONE'
vim.cmd 'au ColorScheme * hi CursorColumn guibg=#404040'
vim.cmd 'au ColorScheme * hi CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow'
vim.cmd 'au ColorScheme * hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE'

-- Float borders
vim.cmd 'au ColorScheme * hi NormalFloat guibg=NONE'
vim.cmd 'au ColorScheme * hi FloatBorder guibg=NONE guifg=#eeeeee'
vim.cmd 'au ColorScheme * hi ErrorFloat guibg=NONE'
vim.cmd 'au ColorScheme * hi WarningFloat guibg=NONE'
vim.cmd 'au ColorScheme * hi InfoFloat guibg=NONE'
vim.cmd 'au ColorScheme * hi HintFloat guibg=NONE'
vim.cmd 'augroup END'

-- ====================================================================================
-- Theme
-- ====================================================================================

vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.relativenumber = true

-- Safely call command to set colorscheme
-- but do not stop execution
local colorscheme_cmd = 'colorscheme onedark'
local success, err = pcall(vim.cmd, colorscheme_cmd)
if not success then
  vim.api.nvim_err_writeln(err)
end

-- ====================================================================================
-- Options
-- ====================================================================================

vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess:append('c')
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.cursorcolumn = true
vim.opt.list = true
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.laststatus = 2
vim.opt.scrolloff = 5
vim.opt.showtabline = 2
vim.opt.ttimeoutlen = 50
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.smarttab = true
vim.opt.cursorline = true

require 'trash'
