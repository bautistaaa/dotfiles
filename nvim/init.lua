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
wo.number = true
wo.numberwidth = 2
o.laststatus = 2
wo.listchars='eol:¬,tab:>·,trail:.,extends:>,precedes:<,space:.'

vim.g.airline_theme='base16'
vim.g.github_enterprise_urls = { 'https://github.prod.hulu.com' }
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_min_count'] = 2
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
vim.g.airline_section_y=''
vim.g.airline_skip_empty_sections = 1
vim.g.mapleader = ' '

vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vertical'
vim.g['test#javascript#jest#options'] = '--watch'

vim.cmd[[colorscheme gloombuddy]]
vim.cmd[[highlight normal guibg=none]]
vim.cmd[[highlight CursorColumn guibg=#404040]]
vim.cmd[[hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow]]
vim.cmd[[hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE]]

--vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
--vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
--vim.cmd[[inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
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
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.cmd[[inoremap <silent><expr> <C-Space> compe#complete()]]
vim.cmd[[inoremap <silent><expr> <C-y>      compe#confirm('<CR>') ]]
vim.cmd[[inoremap <silent><expr> <C-e>     compe#close('<C-e>') ]]
vim.cmd[[inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 }) ]]
vim.cmd[[inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 }) ]]

local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
key_mapper('n', '<leader>s', ':lua require"telescope.builtin".find_files({hidden = true})<CR>')
key_mapper('n', '<leader>f', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_mapper('n', '<Tab>', ':bnext<CR>')
key_mapper('n', '<S-Tab>', ':bprevious<CR>')
key_mapper('n', '<leader>z', ':luafile %<CR>')
key_mapper('n', '<leader>t', ':NERDTreeFind<CR>')
key_mapper('n', '<leader>tt', ':NERDTreeToggle<CR>')
key_mapper('n', '<leader>tc', ':NERDTreeClose<CR>')
key_mapper('n', '<leader>tf', ':NERDTreeFocus<CR>')
key_mapper('n', '<leader>g', ':Gstatus<CR>')
key_mapper('n', '<leader>x', ':bd<CR>')
key_mapper('n', '<leader>xx', ':%bd<CR>')
key_mapper('n', '<C-c>', ':bp|bd #<CR>')
key_mapper('n', '<leader>r', ':%s/<<C-r><C-w>>/')
key_mapper('n', '<leader>u', ':UndotreeToggle<CR>')
key_mapper('n', '<leader>u', ':UndotreeToggle<CR>')
key_mapper('n', '<leader>j', '<C-w><C-j>')
key_mapper('n', '<leader>k', '<C-w><C-k>')
key_mapper('n', '<leader>l', '<C-w><C-l>')
key_mapper('n', '<leader>h', '<C-w><C-h>')
key_mapper('n', '<leader>p', ':PrettierAsync<CR>')
key_mapper('n', '<esc>', ':noh<return><esc>')


local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()
  local use = use
  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'
  use 'mattn/emmet-vim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'anott03/nvim-lspinstall'
  use 'hrsh7th/nvim-compe'

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'

  use 'janko/vim-test'
  use 'preservim/nerdtree'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'
  use 'scrooloose/nerdcommenter'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- these are optional themes but I hear good things about gloombuddy ;)
  -- colorbuddy allows us to run the gloombuddy theme
  use 'tjdevries/colorbuddy.nvim'
  use 'bkegley/gloombuddy'
  -- sneaking some formatting in here too
  use {'prettier/vim-prettier', run = 'yarn install' }
  end
)

local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}

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

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    --vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    --snippets_nvim = true;
    treesitter = true;
  };
}

local function setup_diagnostics()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true,
    }
  )
end
-- add setup_diagnostics() to our custom_on_attach

local lspconfig = require'lspconfig'
local function custom_on_attach(client)
  print('Attaching to ' .. client.name)
  setup_diagnostics()
end
local default_config = {
  on_attach = custom_on_attach,
}
-- setup language servers here
lspconfig.tsserver.setup(default_config)

