local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

map("n", "<leader>cc", ":w | :TermExec cmd='clear && cr %' <CR>", opts)
map("n", "<leader>cr", ":w | :TermExec cmd='clear && cr % -r' <CR>", opts)
map("n", "<leader>cd", ":w | :TermExec cmd='clear && cr % -d' go_back=0<CR>", opts)

