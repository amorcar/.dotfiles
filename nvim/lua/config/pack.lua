-- Plugin installation and loading via vim.pack (nvim 0.12+)
-- All vim.pack.add() calls are centralized here for dependency ordering.
-- Each plugin file in lua/plugins/ exports a setup() function for configuration.

local gh = function(x) return "https://github.com/" .. x end

-- Enable built-in UI2 (messages, cmdline, etc.)
-- TODO: currently breaks cmdline input — investigate compatibility
-- require("vim._core.ui2").enable({})

-- Pack management keymaps
-- to delete a plugin after removing from config: :lua vim.pack.del({ 'nameOfPlugin' })
vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "Pack update" })
vim.keymap.set("n", "<leader>pr", function() vim.pack.update(nil, { target = "lockfile", force = true }) end, { desc = "Pack restore to lockfile" })
vim.keymap.set("n", "<leader>pi", function() vim.pack.update(nil, { offline = true }) end, { desc = "Pack info" })

-- Build step for fff.nvim and treesitter on install/update
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

-- 1. Shared dependencies (must load first)
vim.pack.add({
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("MunifTanjim/nui.nvim"),
  gh("nvim-neotest/nvim-nio"),
})

-- 2. Colorschemes
vim.pack.add({
  gh("rmehri01/onenord.nvim"),
  gh("maxmx03/solarized.nvim"),
  gh("rebelot/kanagawa.nvim"),
  gh("webhooked/kanso.nvim"),
  gh("RRethy/base16-nvim"),
  gh("alexxGmZ/e-ink.nvim"),
  gh("projekt0n/github-nvim-theme"),
})
require("plugins.color").setup()

-- 3. Treesitter (before LSP, as some plugins depend on it)
vim.g.no_plugin_maps = true -- must be set before treesitter-textobjects loads
vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("LiadOz/nvim-dap-repl-highlights"),
  { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
})
require("plugins.treesitter").setup()

-- 4. Completions (before LSP, as lspconfig uses cmp capabilities)
vim.pack.add({
  gh("hrsh7th/cmp-nvim-lsp"),
  gh("saadparwaiz1/cmp_luasnip"),
  gh("rafamadriz/friendly-snippets"),
  gh("L3MON4D3/LuaSnip"),
  gh("hrsh7th/nvim-cmp"),
})
require("plugins.completions").setup()

-- 5. Mason (before lspconfig)
vim.pack.add({
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
})

-- 6. LSP
vim.pack.add({
  gh("folke/lazydev.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("nvimtools/none-ls.nvim"),
  gh("jay-babu/mason-null-ls.nvim"),
})
require("plugins.lsp").setup()

-- 7. Telescope
vim.pack.add({
  gh("mollerhoj/telescope-recent-files.nvim"),
  gh("nvim-telescope/telescope-ui-select.nvim"),
  { src = gh("nvim-telescope/telescope.nvim"), version = vim.version.range("0.1") },
  gh("dmtrKovalenko/fff.nvim"),
})
require("plugins.telescope").setup()

-- 8. Git
vim.pack.add({
  gh("tpope/vim-fugitive"),
  gh("tpope/vim-rhubarb"),
  gh("lewis6991/gitsigns.nvim"),
  gh("sindrets/diffview.nvim"),
  gh("ksaito422/remote-line.nvim"),
})
require("plugins.git").setup()

-- 9. Explorer
vim.pack.add({
  gh("nvim-neo-tree/neo-tree.nvim"),
  gh("stevearc/oil.nvim"),
})
require("plugins.explorer").setup()

-- 10. Harpoon
vim.pack.add({
  { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
})
require("plugins.harpoon").setup()

-- 11. Debugger
vim.pack.add({
  gh("nvim-telescope/telescope-dap.nvim"),
  gh("rcarriga/nvim-dap-ui"),
  gh("theHamsta/nvim-dap-virtual-text"),
  gh("mfussenegger/nvim-dap"),
  gh("jay-babu/mason-nvim-dap.nvim"),
  gh("mfussenegger/nvim-dap-python"),
})
require("plugins.debugger").setup()

-- 12. Misc (pre_setup sets globals before plugins load)
require("plugins.misc").pre_setup()
vim.pack.add({
  gh("tpope/vim-surround"),
  gh("tpope/vim-repeat"),
  gh("tpope/vim-speeddating"),
  gh("tpope/vim-dadbod"),
  gh("kristijanhusak/vim-dadbod-completion"),
  gh("kristijanhusak/vim-dadbod-ui"),
  gh("christoomey/vim-tmux-navigator"),
  gh("jpalardy/vim-slime"),
})
require("plugins.misc").setup()

-- 13. Terminal
vim.pack.add({
  gh("akinsho/toggleterm.nvim"),
})
require("plugins.terminal").setup()

-- 14. Org / notes
vim.pack.add({
  gh("obsidian-nvim/obsidian.nvim"),
  gh("folke/zen-mode.nvim"),
})
require("plugins.org").setup()

-- 15. Rust
vim.pack.add({
  gh("rust-lang/rust.vim"),
  { src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("6") },
})
