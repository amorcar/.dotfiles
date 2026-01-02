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
          "bashls",
          "clangd",
          "lua_ls",
          "ruff",
          "ty",
          -- "pyright",
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

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "lua_ls" })

      vim.lsp.config("terraformls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "terraformls" })

      vim.lsp.config("clangd", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "clangd" })

      -- vim.lsp.config("pyright", {
      --   capabilities = capabilities,
      -- })
      -- vim.lsp.enable({ "pyright" })

      -- Optional: Only required if you need to update the language server settings
      vim.lsp.config('ty', {
        capabilities = capabilities,
        settings = {
          ty = {
            -- ty language server settings go here
          }
        }
      })
      -- Required: Enable the language server
      vim.lsp.enable('ty')

      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition)
      vim.keymap.set("n", "grD", vim.lsp.buf.declaration)
      vim.keymap.set("n", "<leader>ltd", vim.lsp.buf.type_definition)
      vim.keymap.set("n", "<leader>lgd", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>lfm", vim.lsp.buf.format)
      vim.keymap.set("n", "<leader>ltd", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end, { silent = true, noremap = true })
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
          -- null_ls.builtins.formatting.sql_formatter.with({ command = { "sleek", "--indent-spaces", "2" } }),
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
          -- "sqlfmt",
          -- "sqlfluff",
          -- "sleek",
          -- "sqruff",
        },
      })
    end,
  },
}
