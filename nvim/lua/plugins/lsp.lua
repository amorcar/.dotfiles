local M = {}

function M.setup()
  -- mason
  require("mason").setup({
    PATH = "append",
  })

  -- mason-lspconfig
  require("mason-lspconfig").setup({
    automatic_enable = { exclude = { "harper_ls" } },
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

  -- lazydev
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })

  -- lspconfig
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
  -- harper_ls disabled by default, toggle with <leader>lth
  vim.lsp.enable("harper_ls", false)

  vim.lsp.inlay_hint.enable(false)
  vim.diagnostic.config({ virtual_text = true, virtual_lines = true })

  -- shadows built-in <C-k> (digraph insert)
  -- Show function signature in insert mode. Tries signatureHelp first,
  -- falls back to hover on the function name (ty doesn't support
  -- signatureHelp right after "(" with no args typed).
  vim.keymap.set("i", "<C-k>", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return end
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    -- Always hover on the function name for consistent display.
    local depth, pos = 0, col
    while pos > 0 do
      pos = pos - 1
      local c = line:sub(pos + 1, pos + 1)
      if c == ")" then depth = depth + 1
      elseif c == "(" then
        if depth == 0 then break end
        depth = depth - 1
      end
    end
    if pos > 0 then
      local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding)
      params.position.character = pos - 1
      vim.lsp.buf_request(0, "textDocument/hover", params)
    end
  end)
  -- complements built-in gr* namespace (grn, grr, gra, gri, grt are built-in 0.12)
  vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
  vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })
  -- grt (type definition) is built-in in 0.12
  vim.keymap.set("n", "<leader>lsd", vim.diagnostic.open_float, { desc = "LSP show diagnostic" })
  vim.keymap.set("n", "<leader>lsl", function()
    require("telescope.builtin").diagnostics({ bufnr = 0 })
  end, { desc = "LSP show diagnostics list" })
  vim.keymap.set("n", "<leader>lfd", vim.lsp.buf.format, { desc = "LSP format document" })
  vim.keymap.set("n", "<leader>ltd", function()
    local enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
    vim.diagnostic.enable(not enabled, { bufnr = 0 })
  end, { silent = true, noremap = true, desc = "LSP toggle diagnostics" })
  vim.keymap.set("n", "<leader>lti", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { silent = true, noremap = true, desc = "LSP toggle inlay hints" })
  vim.keymap.set("n", "<leader>lth", function()
    local clients = vim.lsp.get_clients({ name = "harper_ls" })
    if #clients > 0 then
      for _, client in ipairs(clients) do
        vim.diagnostic.reset(client.id)
        client:stop()
      end
      vim.lsp.enable("harper_ls", false)
    else
      vim.lsp.enable("harper_ls", true)
    end
  end, { silent = true, noremap = true, desc = "LSP toggle harper" })

  -- none-ls
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.sql_formatter.with({
        extra_args = {
          "--language", "postgresql",
          "--config", vim.fn.expand("~/.config/sql-formatter.json"),
        },
      }),
    },
  })

  -- mason-null-ls
  require("null-ls.config")
  require("mason-null-ls").setup({
    automatic_installation = {},
    ensure_installed = {
      "stylua",
      "prettier",
      "eslint",
      "sql_formatter",
    },
  })
end

return M
