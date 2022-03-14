-- Install packer automatically
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system(
    {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
  )
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    return
end

-- Have packer use a popup window
--packer.init {
--  display = {
--    open_fn = function()
--      return require("packer.util").float { border = "rounded" }
--    end,
--  },
--}

return require('packer').startup(function(use)
  -- My plugins here
  -- Have packer manage itself
  use "wbthomason/packer.nvim"

  -- VIM enhancements
  use 'justinmk/vim-sneak'
  use 'tpope/vim-commentary'

  -- GUI enhancements
  use 'arcticicestudio/nord-vim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'lukas-reineke/indent-blankline.nvim'

  -- Fuzzy finder
  use 'airblade/vim-rooter'
  use {'junegunn/fzf', run = '~/.fzf/install --all'}
  use 'junegunn/fzf.vim'

  -- Semantic language support
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use {'hrsh7th/cmp-nvim-lsp', branch = 'main'}
  use {'hrsh7th/nvim-cmp', branch = 'main'}
  use 'ray-x/lsp_signature.nvim'

  -- cmp-nvim extras
  use {'hrsh7th/cmp-path', branch = 'main'}
  use {'hrsh7th/cmp-buffer', branch = 'main'}
  use 'hrsh7th/cmp-cmdline'
  use {'hrsh7th/cmp-vsnip', branch = 'main'}
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  -- Syntactic language support
  use 'cespare/vim-toml'
  use 'stephpy/vim-yaml'
  use 'rust-lang/rust.vim'
  use 'rhysd/vim-clang-format'
  use 'dag/vim-fish'
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
