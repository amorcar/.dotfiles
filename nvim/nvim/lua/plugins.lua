return {
	{ "tpope/vim-surround" },

	{ "tpope/vim-commentary" },

  -- rust
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^4", -- Recommended
	-- 	ft = { "rust" },
	-- },
  -- git
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require('gitsigns')
      gs.setup()
      vim.keymap.set('n', '<leader>hb', gs.blame_line, {})
      vim.keymap.set('n', '<leader>htb', gs.toggle_current_line_blame, {})
      vim.keymap.set('n', '<leader>htd', gs.toggle_deleted, {})
      vim.keymap.set('n', '<leader>hsd', gs.preview_hunk, {})
      -- vim.keymap.set('n', '<leader>htD', gs.diffthis, {})
    end
  },
}
