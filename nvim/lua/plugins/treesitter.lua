-- treesitter
return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		build = ":TSUpdate",
		config = function()
			local ts_configs = require("nvim-treesitter.configs")
			ts_configs.setup({
				ensure_installed = {
					"c",
					"json",
					"lua",
					"markdown",
					"python",
					"rust",
					"sql",
					"terraform",
					"toml",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							-- defined in textobjects.scm
							["am"] = { query = "@function.outer", desc = "around function" },
							["im"] = { query = "@function.inner", desc = "in function" },
						},
						selection_modes = {
							["@parameter.outer"] = "v",
							["@function.outer"] = "V",
							["@class.outer"] = "<c-v>",
						},
						include_surrounding_whitespace = false,
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		depends = { "nvim-treesitter/nvim-treesitter" },
	},
}
