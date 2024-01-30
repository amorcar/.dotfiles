---@type ChadrcConfig
local M = {}
M.ui = { theme = 'onenord', theme_toggle = { 'onenord', 'onenord_light' } }
M.plugins = 'custom.plugins'
M.mappings = require 'custom.mappings'

-- vim.o.foldmethod = 'indent'
-- vim.o.foldmethod='expr'
-- vim.o.foldexpr=nvim_treesitter#foldexpr()


return M
