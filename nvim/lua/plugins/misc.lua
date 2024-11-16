return {
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>hos", ":G<CR>", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup()
			vim.keymap.set("n", "<leader>hbl", gs.blame_line, {})
			vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, {})
			vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, {})
			vim.keymap.set("n", "<leader>hsd", gs.preview_hunk, {})
			-- vim.keymap.set('n', '<leader>hsD', gs.diffthis, {})
			vim.keymap.set("n", "[C", gs.prev_hunk, {})
			vim.keymap.set("n", "]C", gs.next_hunk, {})
		end,
	},
	{
		"sindrets/diffview.nvim",
		-- keymaps = {
		--   file_panel = {
		--     {
		--       "n", "cc",
		--       "<Cmd>Git commit <bar> wincmd J<CR>",
		--       { desc = "Commit staged changes" },
		--     },
		--     {
		--       "n", "ca",
		--       "<Cmd>Git commit --amend <bar> wincmd J<CR>",
		--       { desc = "Amend the last commit" },
		--     },
		--     {
		--       "n", "c<space>",
		--       ":Git commit ",
		--       { desc = "Populate command line with \":Git commit \"" },
		--     },
		--   },
		-- },
		config = function()
			vim.keymap.set("n", "<leader>hod", ":DiffviewOpen<CR>", {})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				disable_hint = true,
				kind = "split",
				commit_editor = {
					kind = "split",
					show_staged_diff = false,
					staged_diff_split_kind = "split",
					spell_check = true,
				},
			})
		end,
	},
}
