local plugins = {

  {
    'jose-elias-alvarez/null-ls.nvim',
    ft = {'python'},
    opts = function()
      require 'custom.configs.null-ls'
    end
  },

  {
    'neovim/nvim-lspconfig',

    dependencies = {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require 'custom.configs.null-ls'
      end,
    },

    config = function()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end,
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'black',
        'rust-analyzer',
        'mypy',
        'ruff',
        'pyright',
        'terraform-ls',
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        -- defaults 
        'vim',
        'lua',

        -- misc
        'json',
        'toml',
        'yaml',

        -- high level
        'python',

        -- low level
        'rust',

        --iac
        'terraform',
      },
    },
  },

  {
    'kylechui/nvim-surround',
    lazy = false,
    config = function()
      require('nvim-surround').setup()
    end
  },

  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    dependencies = 'neovim/nvim-lspconfig',
    opts = function ()
      return require 'custom.configs.rust-tools'
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  },

  -- {
  --   'mfussenegger/nvim-dap',
  -- },

  {
    'saecki/crates.nvim',
    ft = {'rust', 'toml'},
    config = function(_, opts)
      require('crates').setup(opts)
    end
  },

  {
    'hrsh7th/nvim-cmp',
    opts = function ()
      local M = require 'plugins.configs.cmp'
      table.insert(M.sources, {name = 'crates'})
      return M
    end
  },

}

return plugins

