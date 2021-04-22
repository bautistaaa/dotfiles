-- ====================================================================================
-- Functions
-- ====================================================================================

-- For plugins that use g: for configurations
local function plugins_init()
  vim.g.airline_theme = 'base16'
  vim.g.github_enterprise_urls = { 'https://github.prod.hulu.com' }
  vim.g.airline_powerline_fonts = 1
  vim.g['airline#extensions#tabline#enabled'] = 1
  vim.g['airline#extensions#tabline#buffer_min_count'] = 2
  vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
  vim.g.airline_section_y = ''
  vim.g.airline_skip_empty_sections = 1
  vim.g.mapleader = ' '
  vim.g['test#strategy'] = 'neovim'
  vim.g['test#neovim#term_position'] = 'vertical'
  vim.g['test#javascript#jest#options'] = '--watch'
end

-- For plugins that use a setup() function for configurations
local function plugins_setup()
  local saga = require 'lspsaga'
  saga.init_lsp_saga()

  -- Treesitter options
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
    'css',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'python',
    'tsx',
    'typescript',
    'svelte'
  },
    highlight = { enable = true }
  }

  -- Telescope options
  local telescope = require 'telescope'
  local telescope_actions = require 'telescope.actions'
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-k>'] = telescope_actions.move_selection_previous,
          ['<C-j>'] = telescope_actions.move_selection_next
        }
      }
    }
  }

  -- Compe options
  require 'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = true,
      buffer = true,
      -- calc = true,
      --vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
      -- tags = true,
      -- snippets_nvim = true,
      -- treesitter = true,
    },
  }

  -- LSP options
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true,
    }
  )

  local lspconfig = require 'lspconfig'
  local function on_attach(client)
    print('Attaching to ' .. client.name)
  end
  local default_config = { on_attach = on_attach }
  -- require 'diagnosticls-nvim'.init {
  --   on_attach = on_attach -- Your custom attach function
  -- }


  -- Language Servers Here
  lspconfig.tsserver.setup(vim.tbl_extend('force', default_config, {
    -- Extra options here
  }))

  -- local eslint = require 'diagnosticls-nvim.linters.eslint'
  -- local prettier = require 'diagnosticls-nvim.formatters.prettier'
  -- require 'diagnosticls-nvim'.setup {
  --   ['javascript'] = {
  --     linter = eslint,
  --     formatter = prettier
  --   },
  --   ['javascriptreact'] = {
  --     linter = eslint,
  --     formatter = prettier
  --   },
  --   ['typescript'] = {
  --     linter = eslint,
  --     formatter = prettier
  --   },
  --   ['typescriptreact'] = {
  --     linter = eslint,
  --     formatter = prettier
  --   }
  -- }
end

-- Global key mapper
local function key_mapper(mode, lhs, rhs, opts)
  local def_opts = { noremap = true, silent = true }
  if opts == nil then opts = {} end
  local keyopts = vim.tbl_extend('force', def_opts, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, keyopts)
end

-- Buffer key mapper, use only inside attachment
local function buf_key_mapper(mode, lhs, rhs, opts)
  local def_opts = { noremap = true, silent = true }
  if opts == nil then opts = {} end
  local keyopts = vim.tbl_extend('force', def_opts, opts)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, keyopts)
end

-- Dumb way to set an autocmd group
local function set_augroup(group, autocmds)
  local cmd = vim.api.nvim_command
  cmd('augroup ' .. group)
  cmd('au!')
  for _, autocmd in pairs(autocmds) do cmd(autocmd) end
  cmd('augroup end')
end

-- More Compe Options
-- ===
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
  --   return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
  --   return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

-- ====================================================================================
-- Plugins
-- ====================================================================================

-- Ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- For plugins that use g: vars
plugins_init()

vim.cmd 'packadd packer.nvim'
local packer = require 'packer'
packer.startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-lua/telescope.nvim', requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' } }
  -- use 'jremmen/vim-ripgrep'

  -- Core
  use 'janko/vim-test'
  use 'preservim/nerdtree'
  use 'mbbill/undotree'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'mattn/emmet-vim'
  use 'tpope/vim-fugitive'
  use 'kevinhwang91/nvim-bqf'
  use { 'tpope/vim-rhubarb', requires = { 'tpope/vim-fugitive' } }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'anott03/nvim-lspinstall'
  use 'hrsh7th/nvim-compe'
  -- use 'creativenull/diagnosticls-nvim'
  use 'dense-analysis/ale'
  use 'glepnir/lspsaga.nvim'

  -- Theme/Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'sheerun/vim-polyglot'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  -- these are optional themes but I hear good things about gloombuddy ;)
  -- colorbuddy allows us to run the gloombuddy theme
  use 'tjdevries/colorbuddy.nvim'
  use { 'bkegley/gloombuddy', requires = { 'tjdevries/colorbuddy.nvim' } }
  -- sneaking some formatting in here too
  -- more like comment out that sneak ;)
  -- use { 'prettier/vim-prettier', run = 'yarn install' }
end)

-- For plugins the use setup()
plugins_setup()

-- ====================================================================================
-- Autocmds
-- ====================================================================================

vim.cmd 'augroup colorscheme_opts'
vim.cmd 'au!'
vim.cmd 'au ColorScheme * hi! Normal guibg=none'
vim.cmd 'au ColorScheme * hi! CursorColumn guibg=#404040'
vim.cmd 'au ColorScheme * hi! CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow'
vim.cmd 'au ColorScheme * hi! LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE'
vim.cmd 'augroup END'

-- ====================================================================================
-- Theme
-- ====================================================================================

vim.o.termguicolors = true
vim.wo.relativenumber = true
vim.o.relativenumber = true

vim.cmd 'colorscheme gloombuddy'

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
-- vim.wo.listchars = 'eol:¬,tab:>·,trail:.,extends:>,precedes:<,space:.'
vim.o.scrolloff = 5

-- ====================================================================================
-- Keybindings
-- ====================================================================================

-- Leader
vim.g.mapleader = ' '

-- Keymaps
key_mapper('n', '<up>',       '<nop>')
key_mapper('n', '<down>',     '<nop>')
key_mapper('n', '<left>',     '<nop>')
key_mapper('n', '<right>',    '<nop>')
key_mapper('i', '<up>',       '<nop>')
key_mapper('i', '<down>',     '<nop>')
key_mapper('i', '<left>',     '<nop>')
key_mapper('i', '<right>',    '<nop>')

key_mapper('i', '<Tab>',      'v:lua.tab_complete()', { expr = true })
key_mapper('s', '<Tab>',      'v:lua.tab_complete()', { expr = true })
key_mapper('i', '<S-Tab>',    'v:lua.s_tab_complete()', { expr = true })
key_mapper('s', '<S-Tab>',    'v:lua.s_tab_complete()', { expr = true })
key_mapper('i', '<C-Space>',  'compe#complete()', { expr = true })
key_mapper('i', '<C-y>',      'compe#confirm("<CR>")', { expr = true })
key_mapper('i', '<C-e>',      'compe#close("<C-e>")', { expr = true })
key_mapper('i', '<C-f>',      'compe#scroll({ "delta": +4 })', { expr = true })
key_mapper('i', '<C-d>',      'compe#scroll({ "delta": -4 })', { expr = true })
key_mapper('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw',         '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW',         '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- key_mapper('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
key_mapper('n', '<leader>p',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- key_mapper('n', '<leader>le', [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]])
key_mapper('n', '<leader>s',  '<cmd>lua require"telescope.builtin".find_files({hidden = true})<CR>')
key_mapper('n', '<leader>f',  '<cmd>lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers()<CR>')
key_mapper('n', '<Tab>',      '<cmd>bnext<CR>')
key_mapper('n', '<S-Tab>',    '<cmd>bprevious<CR>')
key_mapper('n', '<leader>z',  '<cmd>luafile $MYVIMRC<CR>')
key_mapper('n', '<leader>t',  '<cmd>NERDTreeFind<CR>')
key_mapper('n', '<leader>tt', '<cmd>NERDTreeToggle<CR>')
key_mapper('n', '<leader>tc', '<cmd>NERDTreeClose<CR>')
key_mapper('n', '<leader>tf', '<cmd>NERDTreeFocus<CR>')
key_mapper('n', '<leader>g',  '<cmd>Gstatus<CR>')
key_mapper('n', '<leader>x',  '<cmd>bd<CR>')
key_mapper('n', '<leader>xx', '<cmd>%bd<CR>')
key_mapper('n', '<C-c>',      '<cmd>bp|bd #<CR>')
key_mapper('n', '<leader>r',  '<cmd>%s/<<C-r><C-w>>/')
key_mapper('n', '<leader>u',  '<cmd>UndotreeToggle<CR>')
key_mapper('n', '<leader>u',  '<cmd>UndotreeToggle<CR>')
key_mapper('n', '<leader>j',  '<C-w><C-j>')
key_mapper('n', '<leader>k',  '<C-w><C-k>')
key_mapper('n', '<leader>l',  '<C-w><C-l>')
key_mapper('n', '<leader>h',  '<C-w><C-h>')
key_mapper('n', '<esc>',      '<cmd>noh<return><esc>')
key_mapper('n', '<leader>lo', ':lopen<CR>')
key_mapper('n', 'K', ':Lspsaga hover_doc<CR>')
-- key_mapper('n', '<leader>ls', ':Lspsaga show_line_diagnostics<CR>')

--vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
--vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
--vim.cmd[[inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]
