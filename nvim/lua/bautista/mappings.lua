local vim = vim
local utils = require'bautista.utils'

local setup_mappings = function()
  vim.cmd[[colorscheme gloombuddy]]
  vim.cmd[[highlight normal guibg=none]]
  vim.cmd[[highlight CursorColumn guibg=#404040]]
  vim.cmd[[hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow]]
  vim.cmd[[hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE]]

  -- Completion
  vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
  vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
  vim.cmd[[inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]

  utils.key_mapper('', '<up>', '<nop>')
  utils.key_mapper('', '<down>', '<nop>')
  utils.key_mapper('', '<left>', '<nop>')
  utils.key_mapper('', '<right>', '<nop>')
  utils.key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
  utils.key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
  utils.key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
  utils.key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
  utils.key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
  utils.key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
  utils.key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>') -- like vscode peek
  utils.key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>') -- pop up def
  utils.key_mapper('n', '<leader>ac', ':lua vim.lsp.buf.code_action()<CR>')
  utils.key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
  utils.key_mapper('n', '<leader>s', ':lua require"telescope.builtin".find_files({hidden = true})<CR>')
  utils.key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
  utils.key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
  utils.key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
  utils.key_mapper('n', '<Tab>', ':bnext<CR>')
  utils.key_mapper('n', '<S-Tab>', ':bprevious<CR>')
  utils.key_mapper('n', '<leader>z', ':luafile %<CR>')
  utils.key_mapper('n', '<leader>t', ':NERDTreeFind<CR>')
  utils.key_mapper('n', '<leader>tt', ':NERDTreeToggle<CR>')
  utils.key_mapper('n', '<leader>tc', ':NERDTreeClose<CR>')
  utils.key_mapper('n', '<leader>tf', ':NERDTreeFocus<CR>')
  utils.key_mapper('n', '<leader>g', ':Gstatus<CR>')
  utils.key_mapper('n', '<leader>x', ':bd<CR>')
  utils.key_mapper('n', '<leader>xx', ':%bd<CR>')
  utils.key_mapper('n', '<C-c>', ':bp|bd #<CR>')
  utils.key_mapper('n', '<leader>r', ':%s/<<C-r><C-w>>/')
  utils.key_mapper('n', '<leader>u', ':UndotreeToggle<CR>')
  utils.key_mapper('n', '<leader>u', ':UndotreeToggle<CR>')
  utils.key_mapper('n', '<leader>j', '<C-w><C-j>')
  utils.key_mapper('n', '<leader>k', '<C-w><C-k>')
  utils.key_mapper('n', '<leader>l', '<C-w><C-l>')
  utils.key_mapper('n', '<leader>h', '<C-w><C-h>')
  utils.key_mapper('n', '<leader>p', ':PrettierAsync<CR>')
  utils.key_mapper('n', '<esc>', ':noh<return><esc>')
end

setup_mappings()

