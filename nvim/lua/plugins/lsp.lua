-- LSP related plugins
return {
	-- mason
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"ruff",
          "pyright",
          -- "basedpyright", -- much better
					"terraformls",
				},
			})
		end,
	},
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		lazy = false,
		config = function()
			-- config LSP completions
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
			vim.keymap.set("n", "grd", vim.lsp.buf.definition)
			vim.keymap.set("n", "grD", vim.lsp.buf.declaration)
			vim.keymap.set("n", "<leader>ltd", vim.lsp.buf.type_definition)
			vim.keymap.set("n", "<leader>lgd", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>lfm", vim.lsp.buf.format)
			vim.keymap.set("n", "<leader>ltd", function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end, { silent = true, noremap = true })
			vim.keymap.set(
				"n",
				"<leader>lts",
				":syntax off<CR>:TSBufToggle highlight<CR>",
				{ silent = true, noremap = true }
			)
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("null-ls.config")
			require("mason-null-ls").setup({
				automatic_installation = {},
				ensure_installed = {
					"stylua",
					"prettier",
					"eslint",
				},
			})
		end,
	},
}
