local config = require('plugins.configs.lspconfig')

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = {'python'},
})

lspconfig.terraformls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = {'terraform', 'tf'},
})

-- local servers = { "html", "cssls", "clangd"}
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end
