" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/chris.bautista/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/chris.bautista/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/chris.bautista/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/chris.bautista/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/chris.bautista/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  gloombuddy = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/gloombuddy"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  nerdtree = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-colors-xcode"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-colors-xcode"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/chris.bautista/.local/share/nvim/site/pack/packer/start/vim-test"
  }
}

time("Defining packer_plugins", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
