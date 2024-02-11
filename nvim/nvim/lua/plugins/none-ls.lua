return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- lua
					null_ls.builtins.formatting.stylua,
          -- python
					null_ls.builtins.formatting.black,
					null_ls.builtins.diagnostics.ruff,
					null_ls.builtins.diagnostics.mypy,
					-- ts
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.diagnostics.eslint,
				},
			})

			vim.keymap.set("n", "<leader>lfm", vim.lsp.buf.format, {})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("null-ls.config")
			require("mason-null-ls").setup({
				ensure_installed = {
          -- lua
					"stylua",
          -- python
          "black",
          "ruff",
          "mypy",
          -- ts
          "prettier",
          "eslint",
				},
			})
		end,
	},
}
