-- LSP related plugins
return {
  -- mason
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        PATH = "append",
      })
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
          "harper_ls",
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
      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local project_root = vim.fn.getcwd()

      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("terraformls", { capabilities = capabilities })
      vim.lsp.enable("terraformls")

      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.enable("clangd")

      vim.lsp.config("ty", {
        capabilities = capabilities,
        root_dir = project_root,
        cmd_env = { VIRTUAL_ENV = project_root .. "/.venv" },
      })
      vim.lsp.enable("ty")

      vim.lsp.config("ruff", { capabilities = capabilities, root_dir = project_root })
      vim.lsp.enable("ruff")

      vim.lsp.config("harper_ls", {
        capabilities = capabilities,
        root_dir = project_root,
        settings = {
          ["harper-ls"] = {
            linters = {
              SentenceCapitalization = true,
              SpellCheck = true,
            },
          },
        },
      })
      vim.lsp.enable("harper_ls")

      vim.lsp.inlay_hint.enable(false)

      -- Auto-show function signature when typing (
      -- Uses hover on the function name since ty doesn't support
      -- signatureHelp with empty args. Falls back to signatureHelp for ","
      -- which works because there's already content.
      vim.keymap.set("i", "(", function()
        vim.defer_fn(function()
          if vim.fn.mode() ~= "i" then return end
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then return end
          local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding)
          params.position.character = math.max(0, params.position.character - 1)
          vim.lsp.buf_request(0, "textDocument/hover", params)
        end, 300)
        return "("
      end, { expr = true })
      vim.keymap.set("i", ",", function()
        vim.defer_fn(function()
          if vim.fn.mode() ~= "i" then return end
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then return end
          -- Find the function name by searching back for the matching (
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local line = vim.api.nvim_get_current_line()
          local depth, pos = 1, col
          while pos > 0 and depth > 0 do
            pos = pos - 1
            local c = line:sub(pos + 1, pos + 1)
            if c == ")" then depth = depth + 1
            elseif c == "(" then depth = depth - 1
            end
          end
          if depth == 0 and pos > 0 then
            local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding)
            params.position.character = pos - 1
            vim.lsp.buf_request(0, "textDocument/hover", params)
          end
        end, 300)
        return ","
      end, { expr = true })
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition)
      vim.keymap.set("n", "grD", vim.lsp.buf.declaration)
      vim.keymap.set("n", "<leader>lty", vim.lsp.buf.type_definition)
      vim.keymap.set("n", "<leader>lgd", vim.diagnostic.open_float)
      vim.keymap.set("n", "grq", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>lfm", vim.lsp.buf.format)
      vim.keymap.set("n", "<leader>ltd", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>lih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
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
  -- { "numirias/semshi" },
}
