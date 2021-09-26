local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local is_first_time = false

-- Bootstrap packer.nvim - auto install on first-time setup
if fn.empty(fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  is_first_time = true
end

vim.cmd 'packadd packer.nvim'
local packer = require 'packer'

packer.init {
  compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua',
}

packer.startup(function(use)
  -- packer.nvim self-care
  use { 'wbthomason/packer.nvim', opt = true }

  -- Telescope
  use { 'nvim-lua/telescope.nvim', requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' } }

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
  use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'anott03/nvim-lspinstall'
  use 'dense-analysis/ale'
  use 'nathunsmitty/nvim-ale-diagnostic'
  use { 'RishabhRD/nvim-lsputils', requires = {'RishabhRD/popfix'} }
  -- use 'glepnir/lspsaga.nvim'
  -- use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}

  -- Autocompletion and Snippets
  -- use {'SirVer/ultisnips', requires = {'honza/vim-snippets'}}
  use {'hrsh7th/vim-vsnip', requires = {'hrsh7th/vim-vsnip-integ', 'rafamadriz/friendly-snippets'}}

  use {'hrsh7th/nvim-cmp', requires = {
    -- LSP source
    {'hrsh7th/cmp-nvim-lsp'},

    -- Ultisnips Source
    -- {'quangnguyen30192/cmp-nvim-ultisnips'},

    -- VSnip Source
    {'hrsh7th/cmp-vsnip'},
  }}

  -- Theme/Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use { 'prettier/vim-prettier', run = 'yarn install' }
  use 'joshdick/onedark.vim'
end)

if is_first_time then
  vim.cmd('PackerInstall')
end
