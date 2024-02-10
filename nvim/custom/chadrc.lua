---@type ChadrcConfig
local M = {}
M.ui = { theme = 'nord', theme_toggle = { 'nord', 'nord_light' } }
M.plugins = 'custom.plugins'
M.mappings = require 'custom.mappings'

-- vim.o.foldmethod = 'indent'
-- vim.o.foldmethod='expr'
-- vim.o.foldexpr=nvim_treesitter#foldexpr()


return M
