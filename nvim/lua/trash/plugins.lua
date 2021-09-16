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
    use { 'wbthomason/packer.nvim', opt = true }

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
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
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippets
    use 'honza/vim-snippets'
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    -- Theme/Syntax
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
    use { 'prettier/vim-prettier', run = 'yarn install' }
    use 'joshdick/onedark.vim'

end
)


