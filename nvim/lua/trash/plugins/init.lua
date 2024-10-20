local user_plugins = {
  -- Core
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<Leader>g", "<Cmd>Git<CR>", { desc = "Git status" })
    end,
  },
  "tpope/vim-surround",
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "janko/vim-test",
  "jiangmiao/auto-pairs",
  "mattn/emmet-vim",
  {
    "github/copilot.vim",
    config = function()
      require("trash.plugins.configs.copilot")
    end,
  },
  "kevinhwang91/nvim-bqf",
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<Leader>u", "<Cmd>UndotreeToggle<CR>", { desc = "Open undo tree" })
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("trash.plugins.configs.neo-tree")
    end,
  },

  -- Telescope
  {
    "nvim-lua/telescope.nvim",
    version = "^0.8.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("trash.plugins.configs.telescope")
    end,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    version = "^3.13.0",
    config = function()
      require("trash.plugins.configs.which-key")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    version = "^1.0.0",
    dependencies = {
      -- Debuggers
      { "mfussenegger/nvim-dap",                version = "^0.8.0" },
      -- Linter/Formatter
      "nvimtools/none-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
      { "princejoogie/tailwind-highlight.nvim", commit = "cfd53d0f6318e8eaada03e10c7f2e4e57ec430c5" },
      -- Tool installer
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jayp0521/mason-nvim-dap.nvim",
      -- Rust specific
      "simrat39/rust-tools.nvim",
      -- lua specific
      { "folke/neodev.nvim" },
    },
    config = function()
      require("mason").setup()

      -- LSP
      require("trash.plugins.configs.lspconfig")

      -- Debugger
      require("trash.plugins.configs.dap")
    end,
  },

  -- Autocompletion and Snippets
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Cmdline completions
      "hrsh7th/cmp-cmdline",
      -- Path completions
      "hrsh7th/cmp-path",
      -- Buffer completions
      "hrsh7th/cmp-buffer",
      -- LSP completions
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      -- vnsip completions
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("trash.plugins.configs.cmp")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("trash.plugins.configs.treesitter")
    end,
  },

  -- sourcegraph
  {
    "sourcegraph/sg.nvim",
    run = "cargo build --workspace",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Theme/Syntax
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("trash.plugins.configs.ufo")
    end,
  },
  { "catppuccin/nvim", as = "catppuccin" },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trash.plugins.configs.bufferline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trash.plugins.configs.lualine")
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>ll",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  -- Don't leak bro
  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = "Comment",
        patterns = {
          {
            -- Match any file starting with ".env".
            -- This can be a table to match multiple file patterns.
            file_pattern = {
              ".env*",
              "wrangler.toml",
              ".dev.vars",
            },
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
            cloak_pattern = "=.+",
          },
        },
      })
    end,
  }
}

-- Plugin Setup
-- ============
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = user_plugins,
})
