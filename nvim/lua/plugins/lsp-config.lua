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
					"pyright",
					"rust_analyzer",
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			-- vim.keymap.set("n", "K", vim.lsp.buf.hover)
			-- currently on nightly. this will eventually get included in nvim stable
			vim.keymap.set("n", "grn", vim.lsp.buf.rename)
			vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
			vim.keymap.set("v", "gra", vim.lsp.buf.code_action)
			vim.keymap.set("n", "grr", vim.lsp.buf.references)
			vim.keymap.set("n", "gri", vim.lsp.buf.implementation)
			vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol)
			vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

			vim.keymap.set("n", "grd", vim.lsp.buf.definition)
			vim.keymap.set("n", "<leader>lgD", vim.lsp.buf.declaration)
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
			vim.keymap.set("n", "[q", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]q", vim.diagnostic.goto_next)

			-- vim.api.nvim_create_autocmd("LspAttach", {

			-- 	callback = function(args)
			-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
			-- 		if not client then
			-- 			return
			-- 		end
			-- 		-- if client.supports_method("textDocument/implementation") then
			-- 		-- 	-- create a keymap for vim.lsp.buf.implementation
			-- 		-- end

			-- 		-- if client.supports_method("textDocument/completion") then
			-- 		-- 	-- enable autocompletion
			-- 		-- 	vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			-- 		-- end
			-- 		if client.supports_method("textDocument/formatting") then
			-- 			-- format the current buffer on save
			-- 			vim.api.nvim_create_autocmd("BufWritePre", {
			-- 				buffer = args.buf,
			-- 				callback = function()
			-- 					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
			-- 				end,
			-- 			})
			-- 		end
			-- 	end,
			-- })
		end,
	},
}
