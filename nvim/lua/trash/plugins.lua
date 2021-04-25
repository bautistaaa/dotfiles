local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

return packer.startup(function()
    local use = use

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
      -- use 'sheerun/vim-polyglot'
      use 'vim-airline/vim-airline'
      use 'vim-airline/vim-airline-themes'
      -- these are optional themes but I hear good things about gloombuddy ;)
      -- colorbuddy allows us to run the gloombuddy theme
      use 'tjdevries/colorbuddy.nvim'
      use { 'bkegley/gloombuddy', requires = { 'tjdevries/colorbuddy.nvim' } }
      use 'arzg/vim-colors-xcode'
      use 'marko-cerovac/material.nvim'
      -- sneaking some formatting in here too
      -- more like comment out that sneak ;)
      use { 'prettier/vim-prettier', run = 'yarn install' }

    end
)


