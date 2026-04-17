-- Plugin installation via vim.pack (nvim 0.12+)
-- This file loads first (0- prefix) and installs all plugins in a single call.
-- Individual plugin/ files handle their own configuration.

local gh = function(x) return "https://github.com/" .. x end

-- Pre-load globals (must be set before vim.pack.add triggers plugin scripts)
vim.g.no_plugin_maps = true
vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.slime_no_mappings = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_debug = 0
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_save_location = vim.fn.expand("~/.local/share/sql")

-- Build steps on install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec = ev.data.spec
    local kind = ev.data.kind
    if spec.name == "fff.nvim" and (kind == "install" or kind == "update") then
      require("fff.download").download_or_build_binary()
    end
    if spec.name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      vim.cmd("TSUpdate")
    end
  end,
})

-- Single vim.pack.add() call with all plugins
vim.pack.add({
  -- Shared dependencies
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("MunifTanjim/nui.nvim"),
  gh("nvim-neotest/nvim-nio"),

  -- Colorschemes
  gh("rmehri01/onenord.nvim"),
  gh("maxmx03/solarized.nvim"),
  gh("rebelot/kanagawa.nvim"),
  gh("webhooked/kanso.nvim"),
  gh("RRethy/base16-nvim"),
  gh("alexxGmZ/e-ink.nvim"),
  gh("projekt0n/github-nvim-theme"),

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("LiadOz/nvim-dap-repl-highlights"),
  { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },

  -- Completions
  gh("hrsh7th/cmp-nvim-lsp"),
  gh("saadparwaiz1/cmp_luasnip"),
  gh("rafamadriz/friendly-snippets"),
  gh("L3MON4D3/LuaSnip"),
  gh("hrsh7th/nvim-cmp"),

  -- Mason
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),

  -- LSP
  gh("folke/lazydev.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("nvimtools/none-ls.nvim"),
  gh("jay-babu/mason-null-ls.nvim"),

  -- Telescope
  gh("mollerhoj/telescope-recent-files.nvim"),
  gh("nvim-telescope/telescope-ui-select.nvim"),
  { src = gh("nvim-telescope/telescope.nvim"), version = vim.version.range("0.1") },
  -- gh("dmtrKovalenko/fff.nvim"),  -- temporarily disabled

  -- Git
  gh("tpope/vim-fugitive"),
  gh("tpope/vim-rhubarb"),
  gh("lewis6991/gitsigns.nvim"),
  gh("sindrets/diffview.nvim"),
  gh("ksaito422/remote-line.nvim"),

  -- Explorer
  gh("nvim-neo-tree/neo-tree.nvim"),
  gh("stevearc/oil.nvim"),

  -- Harpoon
  { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },

  -- Debugger
  gh("nvim-telescope/telescope-dap.nvim"),
  gh("rcarriga/nvim-dap-ui"),
  gh("theHamsta/nvim-dap-virtual-text"),
  gh("mfussenegger/nvim-dap"),
  gh("jay-babu/mason-nvim-dap.nvim"),
  gh("mfussenegger/nvim-dap-python"),

  -- Misc
  gh("tpope/vim-surround"),
  gh("tpope/vim-repeat"),
  gh("tpope/vim-speeddating"),
  gh("tpope/vim-dadbod"),
  gh("kristijanhusak/vim-dadbod-completion"),
  gh("kristijanhusak/vim-dadbod-ui"),
  gh("christoomey/vim-tmux-navigator"),
  gh("jpalardy/vim-slime"),
  gh("josephburgess/nvumi"),

  -- Terminal
  gh("akinsho/toggleterm.nvim"),

  -- Org / notes
  gh("obsidian-nvim/obsidian.nvim"),
  gh("folke/zen-mode.nvim"),

  -- Rust
  gh("rust-lang/rust.vim"),
  { src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("6") },
})

-- Pack management keymaps
-- to delete a plugin after removing from config: :lua vim.pack.del({ 'nameOfPlugin' })
vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "Pack update" })
vim.keymap.set("n", "<leader>pr", function() vim.pack.update(nil, { target = "lockfile", force = true }) end, { desc = "Pack restore to lockfile" })
vim.keymap.set("n", "<leader>pi", function() vim.pack.update(nil, { offline = true }) end, { desc = "Pack info" })
