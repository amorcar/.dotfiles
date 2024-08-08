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
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark' -- dark or 'light'
      -- vim.cmd.colorscheme 'solarized'
    end,
  },
}
