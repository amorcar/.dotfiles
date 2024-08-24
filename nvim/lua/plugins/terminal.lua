return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {

			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,

      open_mapping = [[<c-\>]],

      shade_terminals = true, -- this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
      shading_factor = '-10', -- the percentage by which to lighten dark terminal background, default: -30
      shading_ratio = '-3', -- the ratio of shading factor for light/dark terminal background, default: -3

      direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float',
		},
	},
}
