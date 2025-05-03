return {
	"ThePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})

		-- -- Configure harpoon to use telescope ui
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

		local map = vim.keymap.set

		map("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list(), {
				-- ui_max_width = 10,  -- Maximum menu width
				-- ui_width_ratio = 0.5  -- Relative width, if I'm not mistaken this is relative to window
				-- ui_min_width = 20,       -- Minimum menu width
				border = "none", -- Window border style
				title = "", -- Custom window title
			})
		end)
		map("n", "<leader>fh", function()
			-- harpoon.ui:toggle_quick_menu(harpoon:list())
			toggle_telescope(harpoon:list())
		end)
		map("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Harpoon: add buffer" })
		map("n", "<leader>h1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: buffer 1" })
		map("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: buffer 2" })
		map("n", "<leader>h3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: buffer 3" })
		map("n", "<leader>h4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon: buffer 4" })
		-- map("n", "<A-P>", function() harpoon:list():prev() end, { desc = "Harpoon: prev buffer" })
		-- map("n", "<A-N>", function() harpoon:list():next() end, { desc = "Harpoon: next buffer" })
	end,
}
