return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gof", ":G<CR>", { desc = "git open fugitive" })
			vim.keymap.set("n", "<leader>gg", ":G<CR>", { desc = "git open fugitive" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup()
			vim.keymap.set("n", "<leader>gbl", gs.blame_line, { desc = "git blame line" })
			vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "git toogle blame" })
			vim.keymap.set("n", "<leader>gtd", gs.preview_hunk_inline, { desc = "git toggle delete" })
			vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "git hunk preview" })
			vim.keymap.set("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]h", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, { desc = "next hunk" })

			vim.keymap.set("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[h", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, { desc = "prev hunk" })
		end,
	},
	{
		"sindrets/diffview.nvim",
		command = "DiffviewOpen",
		config = function()
			local function toggle_diffview(cmd)
				if next(require("diffview.lib").views) == nil then
					vim.cmd(cmd)
				else
					vim.cmd("DiffviewClose")
				end
			end
			vim.keymap.set("n", "<leader>gd", function()
				toggle_diffview("DiffviewOpen")
			end, { desc = "diff index" })
			vim.keymap.set("n", "<leader>gD", function()
				toggle_diffview("DiffviewOpen main..HEAD")
			end, { desc = "diff main" })
			vim.keymap.set("n", "<leader>gf", function()
				toggle_diffview("DiffviewFileHistory %")
			end, { desc = "Open diffs for current File" })
		end,
	},
	{
		"NeogitOrg/neogit",
		enabled = false,
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
			vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "open neogit" })
		end,
	},
}
