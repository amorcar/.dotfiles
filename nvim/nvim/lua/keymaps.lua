-------------------------------------------------------------------------------
-- keymaps
-------------------------------------------------------------------------------
-- quick save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
-- quick close buffer
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>")

-- Ctrl+h to stop searching
vim.keymap.set("v", "<C-h>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<C-h>", "<cmd>nohlsearch<cr>")

-- <leader><leader> toggles between buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- always center search results
vim.keymap.set("n", "n", "nzt", { silent = true })
vim.keymap.set("n", "N", "Nzt", { silent = true })
vim.keymap.set("n", "*", "*zt", { silent = true })
vim.keymap.set("n", "#", "#zt", { silent = true })
vim.keymap.set("n", "g*", "g*zt", { silent = true })

-- center half-page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zt")
vim.keymap.set("n", "<C-u>", "<C-u>zt")

-- center jumplist jumps
vim.keymap.set("n", "<C-o>", "<C-o>zt")
vim.keymap.set("n", "<C-i>", "<C-i>zt")

-- "very magic" (less escaping needed) regexes by default
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("c", "%s/", "%sm/")

-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- escape terminal
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { silent = true })

-- move visual lines
vim.keymap.set("x", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<C-К>", ":m '<-2<CR>gv=gv")

-- a better J that keeps the cursor in the same place
vim.keymap.set("n", "J", "mzJ`z")

-- leader yank to the system clipboard
vim.keymap.set('n', "<leader>y", "\"+y")
vim.keymap.set("x", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
