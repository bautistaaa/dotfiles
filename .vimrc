" vim-plug as the plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

endif
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'anott03/nvim-lspinstall'
Plug 'nvim-lua/completion-nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'ervandew/supertab'                   " better tab completion
Plug 'ianks/vim-tsx'                       " Syntax highlighting and indenting for TSX
Plug 'sheerun/vim-polyglot'                " syntax highlighting
Plug 'janko/vim-test'                      " granular testing
Plug 'jiangmiao/auto-pairs'                " auto close brackets
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                    " fuzzy finding with ag
Plug 'jparise/vim-graphql'                 " graphql syntax
Plug 'mattn/gist-vim'                      " quickly put code into a gist
Plug 'mattn/webapi-vim'                    " quickly put code into a gist
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'prettier/vim-prettier'               " code formatting
Plug 'scrooloose/nerdcommenter'            " easy commenting
Plug 'scrooloose/nerdtree'                 " find files by dir tree
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
"Plug 'drewtempelmeyer/palenight.vim'       " theme
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-dispatch'                  " async command line commands
Plug 'tpope/vim-fugitive'                  " git integration
Plug 'tpope/vim-rhubarb'                   " github for fugitive
Plug 'tpope/vim-surround'                  " surround with tags
Plug 'vim-airline/vim-airline'             " status bar plugin
Plug 'vim-airline/vim-airline-themes'      " airline theme
Plug 'leafgarland/typescript-vim'          " typescript plugin 
Plug 'mbbill/undotree'                     " undo mgmt 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mattn/emmet-vim'                     " emmet
call plug#end()

" map leader to spacebar (best thing ever)
let mapleader = ' '

let g:airline_theme='base16'
let g:github_enterprise_urls = ['https://github.prod.hulu.com']

" theme
set cursorcolumn
syntax enable           " Enable code highlighting
set guioptions-=r
set termguicolors
colorscheme base16-onedark
set background=dark
"hi Normal       ctermfg=250 guifg=#d0d0d0 ctermbg=black guibg=#0c0c0c
highlight Normal guibg=none
highlight CursorColumn guibg=#404040

"s line Numbers
set relativenumber
set number
set numberwidth=2
set laststatus=2
set list
set listchars=eol:¬,tab:>·,trail:.,extends:>,precedes:<,space:.
hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE


" search stuff
set incsearch
set gdefault
set visualbell
set nohlsearch

" characters and movement
filetype plugin indent on
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set backspace=indent,eol,start
set title
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
let g:SuperTabDefaultCompletionType = "<c-n>"

" split windows
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
tnoremap <leader>h <C-\><C-N><C-w>h
tnoremap <leader>j <C-\><C-N><C-w>j
tnoremap <leader>k <C-\><C-N><C-w>k
tnoremap <leader>l <C-\><C-N><C-w>l

" moving between buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" close all buffers
nnoremap <leader>x :bd<CR>
nnoremap <leader>xx :%bd<CR>
nnoremap <C-c> :bp\|bd #<CR>

" search and replace under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

nnoremap <Leader>u :UndotreeToggle<CR>

" set one directory for .swp files
set backupdir=/var/tmp,/tmp
set directory=/var/tmp,/tmp

" Airline / Status line options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_y=''
let g:airline_skip_empty_sections = 1

" vim-fugitive
nnoremap <leader>g :Gstatus<CR>

" vim-test
let test#strategy = 'neovim'
let test#neovim#term_position = "vertical"
let test#javascript#jest#options = '--watch'

" LESS / CSS Highlighting
augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css setlocal iskeyword+=-
augroup END

" vim-prettier options
noremap <leader>p :PrettierAsync<CR>

" FZF options
let g:fzf_layout = { 'down': '~50%' } " - down / up / left / right
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindCurrentWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(expand('<cword>')), 1, <bang>0)
set grepprg=rg\ --vimgrep
noremap <leader>f :FindCurrentWord<CR>
noremap <leader>s :Files<CR>
noremap <leader>b :Buffers<CR>

" NERDCommenter options
let g:NERDCustomDelimiters = { 'less': { 'left': '// ', 'right': '', 'leftAlt': '/* ', 'rightAlt': ' */' }, 'javascript': { 'left': '// ', 'right': '', 'leftAlt': '/* ', 'rightAlt': ' */' } }

" NERDTree options
noremap <leader>t :NERDTreeFind<CR>
noremap <leader>tt :NERDTreeToggle<CR>
noremap <leader>tc :NERDTreeClose<CR>
noremap <leader>tf :NERDTreeFocus<CR>
let g:NERDTreeWinSize = 50

" Language Server (coc) options
let g:coc_global_extensions = ['coc-emmet']
set signcolumn=yes
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
noremap <leader>e :<C-u>CocList diagnostics<cr>
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
set completeopt=longest,menuone
inoremap <silent><expr> <c-space> coc#refresh()
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" disable arrow keys cause im NOOB
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" the below didnt play with HTML, it kept auto selecting first suggestion
"lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.bashls.setup{ on_attach=require'completion'.on_attach }

" GO options
nnoremap <leader>gi :GoImports<CR>
nnoremap <leader>gb :GoBuild<CR>
nnoremap <leader>gf :GoFmt<CR>
nnoremap <leader>gr :GoRun<CR>
