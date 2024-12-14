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
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>ho", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>h1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>h2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>h3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>h4", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<leader>h5", function()
				harpoon:list():select(5)
			end)
			vim.keymap.set("n", "<leader>h6", function()
				harpoon:list():select(6)
			end)
			vim.keymap.set("n", "<leader>h7", function()
				harpoon:list():select(7)
			end)
			vim.keymap.set("n", "<leader>h8", function()
				harpoon:list():select(8)
			end)
			vim.keymap.set("n", "<leader>h9", function()
				harpoon:list():select(9)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end)

			-- basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<C-h>", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Open harpoon window" })
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
      vim.g.db_ui_hide_schemas = { 'pg_toast_temp.*' }
			vim.keymap.set("n", "<leader>dbt", ":DBUIToggle<cr>" , { desc = "Toggle Dadbod UI" })
      vim.api.nvim_command("autocmd FileType dbui nmap <buffer> <tab> <Plug>(DBUI_SelectLine)")
		end,
	},
}
