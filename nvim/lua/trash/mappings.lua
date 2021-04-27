local utils = require'trash.utils'

local setup_mappings = function()
    utils.key_mapper('n', '<up>',       '<nop>')
    utils.key_mapper('n', '<down>',     '<nop>')
    utils.key_mapper('n', '<left>',     '<nop>')
    utils.key_mapper('n', '<right>',    '<nop>')
    utils.key_mapper('i', '<up>',       '<nop>')
    utils.key_mapper('i', '<down>',     '<nop>')
    utils.key_mapper('i', '<left>',     '<nop>')
    utils.key_mapper('i', '<right>',    '<nop>')

    utils.key_mapper('i', '<Tab>',      'v:lua.tab_complete()', { expr = true })
    utils.key_mapper('s', '<Tab>',      'v:lua.tab_complete()', { expr = true })
    utils.key_mapper('i', '<S-Tab>',    'v:lua.s_tab_complete()', { expr = true })
    utils.key_mapper('s', '<S-Tab>',    'v:lua.s_tab_complete()', { expr = true })
    utils.key_mapper('i', '<C-Space>',  'compe#complete()', { expr = true })
    utils.key_mapper('i', '<C-y>',      'compe#confirm("<CR>")', { expr = true })
    utils.key_mapper('i', '<C-e>',      'compe#close("<C-e>")', { expr = true })
    utils.key_mapper('i', '<C-f>',      'compe#scroll({ "delta": +4 })', { expr = true })
    utils.key_mapper('i', '<C-d>',      'compe#scroll({ "delta": -4 })', { expr = true })
    utils.key_mapper('n', '<leader>s',  '<cmd>lua require"telescope.builtin".find_files({hidden = true})<CR>')
    utils.key_mapper('n', '<leader>f',  '<cmd>lua require"telescope.builtin".live_grep()<CR>')
    utils.key_mapper('n', '<leader>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
    utils.key_mapper('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers()<CR>')
    utils.key_mapper('n', '<Tab>',      '<cmd>bnext<CR>')
    utils.key_mapper('n', '<S-Tab>',    '<cmd>bprevious<CR>')
    utils.key_mapper('n', '<leader>z',  '<cmd>luafile $MYVIMRC<CR>')
    utils.key_mapper('n', '<leader>t',  '<cmd>NERDTreeFind<CR>')
    utils.key_mapper('n', '<leader>tt', '<cmd>NERDTreeToggle<CR>')
    utils.key_mapper('n', '<leader>tc', '<cmd>NERDTreeClose<CR>')
    utils.key_mapper('n', '<leader>tf', '<cmd>NERDTreeFocus<CR>')
    utils.key_mapper('n', '<leader>g',  '<cmd>Gstatus<CR>')
    utils.key_mapper('n', '<leader>x',  '<cmd>bd<CR>')
    utils.key_mapper('n', '<leader>xx', '<cmd>%bd<CR>')
    utils.key_mapper('n', '<C-c>',      '<cmd>bp|bd #<CR>')
    utils.key_mapper('n', '<leader>r',  '<cmd>%s/<<C-r><C-w>>/')
    utils.key_mapper('n', '<leader>u',  '<cmd>UndotreeToggle<CR>')
    utils.key_mapper('n', '<leader>u',  '<cmd>UndotreeToggle<CR>')
    utils.key_mapper('n', '<leader>j',  '<C-w><C-j>')
    utils.key_mapper('n', '<leader>k',  '<C-w><C-k>')
    utils.key_mapper('n', '<leader>l',  '<C-w><C-l>')
    utils.key_mapper('n', '<leader>h',  '<C-w><C-h>')
    utils.key_mapper('n', '<esc>',      '<cmd>noh<return><esc>')
    utils.key_mapper('n', '<leader>lo', ':lopen<CR>')
    utils.key_mapper('n', 'K', ':Lspsaga hover_doc<CR>')
    utils.key_mapper('n', '<leader>p', ':PrettierAsync<CR>')
end

setup_mappings()

