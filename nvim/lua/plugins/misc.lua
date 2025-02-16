return {
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
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
			vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted, { desc = "git toggle delete" })
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
		config = function()
			vim.keymap.set("n", "<leader>god", ":DiffviewOpen<CR>", { desc = "git open diff" })
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
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_execute_on_save = 1
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1
			vim.g.db_ui_winwidth = 35
			vim.g.db_ui_hide_schemas = { "pg_toast_temp.*" }
			vim.keymap.set("n", "<leader>tdb", ":DBUIToggle<cr>", { desc = "Toggle Dadbod UI" })
			vim.api.nvim_command("autocmd FileType dbui nmap <buffer> <tab> <Plug>(DBUI_SelectLine)")
		end,
	},
	{
		"folke/which-key.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"shellRaining/hlchunk.nvim",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				indent = {
					enable = false,
					chars = {
						"│",
						"¦",
						"┆",
						"┊",
					},
				},
				chunk = {
					enable = true,
					-- style = {
					-- 	{ fg = "#806d9c" },
					-- 	{ fg = "#c21f30" },
					-- },
					use_treesitter = true,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						-- right_arrow = ">",
						right_arrow = "─",
					},
					textobject = "",
					max_file_size = 1024 * 1024,
					error_sign = true,
					-- animation related
					duration = 20,
					delay = 30,
				},
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		enabled = false,
		config = function()
			require("illuminate").configure({
				delay = 1000,
				under_cursor = true,
				vim.keymap.set("n", "<leader>twh", ":IlluminateToggle<cr>", { desc = "Toggle Dadbod UI" }),
				vim.api.nvim_create_autocmd("ColorScheme", {
					pattern = "*",
					callback = function()
						vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#252535", underline = false })
					end,
				}),
			})
		end,
	},
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
			{ "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
			{ "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
			{ "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
			{ "<M-w>", "<cmd>TmuxNavigatePrevious<cr>" },
		},
		config = function()
			vim.cmd([[
        let g:tmux_navigator_no_mappings = 1
        let g:tmux_navigator_disable_when_zoomed = 1
      ]])
		end,
	},
}
