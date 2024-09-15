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
          -- lua
          "lua_ls",
          --rust
          "rust_analyzer",
          -- python
          "pyright",
          -- terraform
          "terraformls",
          -- c
          "clangd",
        },
      })
    end,
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
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

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      -- vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
      -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      -- vim.keymap.set("n", "<leader>tt", vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()))
    end,
  },
}
