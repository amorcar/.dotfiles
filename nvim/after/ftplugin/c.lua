local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

map("n", "<leader>rr", ":w | :TermExec cmd='clear && cr %' <CR>", opts)
map("n", "<leader>rd", ":w | :TermExec cmd='clear && cr % -d' go_back=0<CR>i", opts)

