local cmd = vim.cmd
local u = require('user.utils')

u.create_augroup({
    --{ 'CursorHold,CursorHoldI', '*.rs', ':lua require"lsp_extensions".inlay_hints { only_current_line = true } ' },
    { 'Filetype', 'rust', 'set colorcolumn=100' },
}, 'rust_au')

u.create_augroup({
    { 'InsertLeave', '*', 'set nopaste' },
}, 'pastemode_au')

u.create_augroup({
    { 'Syntax', 'vim', 'setlocal foldmethod=marker' },
    { 'Filetype', 'vim', 'setlocal foldmethod=marker' },
}, 'vim_au')

u.create_augroup({
    { 'BufWinLeave', '*', 'mkview' },
    { 'BufWinEnter', '*', 'silent! loadview' },
}, 'saveSession')

u.create_augroup({
    { 'BufEnter,FocusGained,InsertLeave', '*', 'set relativenumber' },
    { 'BufLeave,FocusLost,InsertEnter', '*', 'set norelativenumber' },
}, 'relativenumber')

u.create_augroup({
    { 'BufWritePre', '*.lua,*.rs,*.py', 'lua vim.lsp.buf.formatting()' },
}, 'lua')

--cmd('au BufNewFile,BufRead * if &ft == "" | set ft=text | endif')

-- vim.cmd [[
--]]
-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
