return {
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gof", ":G<CR>", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup()
			vim.keymap.set("n", "<leader>gbl", gs.blame_line, {})
			vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, {})
			vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted, {})
			vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, {})
			vim.keymap.set("n", "[h", gs.prev_hunk, {})
			vim.keymap.set("n", "]h", gs.next_hunk, {})
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", "<leader>god", ":DiffviewOpen<CR>", {})
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
				kind = "split",
        disable_signs = true,
				disable_hint = true,
        graph_style = "unicode",
				commit_editor = {
					kind = "split",
					show_staged_diff = false,
					staged_diff_split_kind = "split",
					spell_check = true,
				},
			})
			vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", {})
		end,
	},
}

