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
			vim.o.termguicolors = true
			require("solarized").setup({
				theme = "neo", -- or comment to use solarized default theme.
				palette = "solarized", -- solarized (default) | selenized
				-- https://github.com/maxmx03/solarized.nvim/blob/main/VARIANTS.md
				variant = "autumn", -- "spring" | "summer" | "autumn" | "winter" (default)
				styles = {
					comments = { italic = true, bold = true },
					functions = { italic = false },
					variables = { italic = false },
					types = {},
					parameters = {},
					strings = { italic = true },
					keywords = {},
					constants = {},
				},
				error_lens = {
					text = false,
					symbol = true,
				},
				plugins = {
					treesitter = true,
					lspconfig = true,
					neotree = true,
					whichkey = true,
					dashboard = true,
					gitsigns = true,
					telescope = true,
					lazy = true,
					gitgutter = true,
				},
				transparent = {
					enabled = true, -- Master switch to enable transparency
					pmenu = false, -- Popup menu (e.g., autocomplete suggestions)
					normal = false, -- Main editor window background
					normalfloat = false, -- Floating windows
					telescope = true, -- Telescope fuzzy finder
					lazy = false, -- Lazy plugin manager UI
					mason = false, -- Mason manage external tooling
				},
				on_highlights = function(colors, color)
					-- local darken = color.darken
					local lighten = color.lighten
					-- local blend = color.blend
					local shade = color.shade
					-- local tint = color.tint
					local groups = {
						Function = { fg = colors.base1 },
            DiagnosticUnderlineError = { fg = ''},
            DiagnosticUnderlineWarn  = { fg = ''},
            DiagnosticUnderlineInfo  = { fg = ''},
            DiagnosticUnderlineHint  = { fg = ''},
            DiffAdd = { bg = '#0c4e53', fg = '' },
            DiffDelete = { bg = '#422d33', fg = '', reverse = false},
            DiffChange = { bg = shade('#204060', 2.5), fg = '' },
            DiffText = { bg = lighten('#204060', 2.5), fg = '', reverse = false  },
					}

					return groups
				end,
			})
		end,
	},
}
