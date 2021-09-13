require('lualine').setup{
  options = { theme  = 'nightfly' },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 2 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  },
}
