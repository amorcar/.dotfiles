return {
	{ "tpope/vim-surround" },

	{ "tpope/vim-commentary" },
	-- git
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup()
			vim.keymap.set("n", "<leader>hb", gs.blame_line, {})
			vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, {})
			vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, {})
			vim.keymap.set("n", "<leader>hsd", gs.preview_hunk, {})
			-- vim.keymap.set('n', '<leader>hsD', gs.diffthis, {})
			vim.keymap.set("n", "[c", gs.prev_hunk, {})
			vim.keymap.set("n", "]c", gs.next_hunk, {})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
        global_settings = {
          save_on_toggle = true,
          mark_branch = true,
        }
      })

      -- telescope config
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

      -- keymaps
			vim.keymap.set("n", "<leader>fh", function()
				toggle_telescope(harpoon:list())
			end, { desc = "(f)ind (h)arpoon" })

			vim.keymap.set("n", "<C-h>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():append()
			end, { desc = "(h)arpoon (a)dd" })
			vim.keymap.set("n", "<leader>h1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>h2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>h3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-j>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-k>", function()
				harpoon:list():next()
			end)
		end,
	},
}
