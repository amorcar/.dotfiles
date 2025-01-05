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
						DiagnosticUnderlineError = { fg = "" },
						DiagnosticUnderlineWarn = { fg = "" },
						DiagnosticUnderlineInfo = { fg = "" },
						DiagnosticUnderlineHint = { fg = "" },
						DiffAdd = { bg = "#0c4e53", fg = "" },
						DiffDelete = { bg = "#422d33", fg = "", reverse = false },
						DiffChange = { bg = shade("#204060", 2.5), fg = "" },
						DiffText = { bg = lighten("#204060", 2.5), fg = "", reverse = false },
					}

					return groups
				end,
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						lotus = {},
						dragon = {},
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Block-like modern Telescope UI
						-- TelescopeTitle = { fg = theme.ui.special, bold = false },
						-- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						-- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						-- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						-- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						-- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						-- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            -- More uniform colors for the popup menu
            -- add `blend = vim.o.pumblend` to enable transparency
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
						PmenuExtra = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuExtraSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
            PmenuKind = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuKindSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})

			-- setup must be called before loading
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
