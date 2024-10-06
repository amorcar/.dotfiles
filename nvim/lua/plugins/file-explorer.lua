return {
	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		enable = true,
		name = "neo-tree",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				default_component_configs = {
					icon = {
						enabled = true,
					},
					name = {
						trailing_slash = false,
					},
					indent = {
						indent_marker = " ",
						last_indent_marker = " ",
					},
				},
				window = {
					position = "left",
					width = 25,
				},
			})
			vim.keymap.set(
				"n",
				"<leader>b",
				"<Cmd>Neotree toggle filesystem reveal left<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
	-- oil
	{
		"stevearc/oil.nvim",
		opts = {},
		enable = true,
		name = "oil",
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = {
					-- "icon",
					"permissions",
					"size",
					"mtime",
				},
				delete_to_trash = false,
				skip_confirm_for_simple_edits = true,
				prompt_save_on_select_new_entry = true,
				-- Constrain the cursor to the editable parts of the oil buffer
				-- Set to `false` to disable, or "name" to keep it on the file names
				constrain_cursor = "editable",
				-- Set to true to watch the filesystem for changes and reload oil
				watch_for_changes = false,
				keymaps = {
					["gf"] = "actions.select",
					["gp"] = "actions.preview",
					["<C-p>"] = false, -- disable so it does not conflict w telescope
				},
			})
			vim.keymap.set("n", "<C->", "<CMD>10 sp|Oil<CR>", { desc = "Open parent directory" })
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
}
