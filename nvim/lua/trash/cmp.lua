local utils = require 'trash.utils'
local cmp = require 'cmp'

-- UltiSnips
-- vim.cmd 'augroup ultisnips_user_events'
-- vim.cmd 'au!'
-- vim.cmd 'au FileType javascriptreact UltiSnipsAddFiletypes javascript'
-- vim.cmd 'au FileType typescriptreact UltiSnipsAddFiletypes typescript'
-- vim.cmd 'augroup END'

-- vsnip
vim.g.vsnip_filetypes = {
  javascriptreact = {'javascript'},
  typescriptreact = {'typescript'},
}

local keyopts = { expr = true, noremap = false }
utils.key_mapper('i', '<C-j>', 'vsnip#jumpable(1)  ? "\\<Plug>(vsnip-jump-next)" : "\\<Tab>"', keyopts)
utils.key_mapper('s', '<C-j>', 'vsnip#jumpable(1)  ? "\\<Plug>(vsnip-jump-next)" : "\\<Tab>"', keyopts)
utils.key_mapper('i', '<C-k>', 'vsnip#jumpable(-1) ? "\\<Plug>(vsnip-jump-prev)" : "\\<S-Tab>"', keyopts)
utils.key_mapper('s', '<C-k>', 'vsnip#jumpable(-1) ? "\\<Plug>(vsnip-jump-prev)" : "\\<S-Tab>"', keyopts)

-- Setup nvim-cmp
cmp.setup {
  snippet = {
    expand = function(args)
      -- vim.fn["UltiSnips#Anon"](args.body)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i'}),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i'}),
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'ultisnips' },
    { name = 'vsnip' },
  },

  formatting = {
    format = function(entry, item)
      item.menu = ({
        nvim_lsp = '[lsp]',
        -- ultisnips = '[ultisnips]',
        vsnip = '[vsnip]',
      })[entry.source.name]

      return item
    end,
  },
}
