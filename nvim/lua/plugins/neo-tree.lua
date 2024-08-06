-- neotree
return {
	"nvim-neo-tree/neo-tree.nvim",
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
		vim.keymap.set("n", "<C-b>", ":Neotree toggle filesystem reveal left<cr>")
	end,
}
