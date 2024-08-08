-- colorscheme
return {
	{
		"rmehri01/onenord.nvim",
		name = "onenord",
		lazy = false,
		priority = 1000,
		config = true,
	},
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = "dark" -- dark or 'light'
      require("solarized").setup({
        -- theme = "neo", -- or comment to use solarized default theme.
        styles = {
          comments = { italic = true, bold = true },
          functions = { italic = true },
          variables = { italic = false },
        },
      })
		end,
	},
}
