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
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })

-- center half-page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center jumplist jumps
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

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
-- vim.keymap.set("x", "<C-J>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("x", "<C-К>", ":m '<-2<CR>gv=gv")

-- a better J that keeps the cursor in the same place
vim.keymap.set("n", "J", "mzJ`z")

-- leader yank to the system clipboard
vim.keymap.set('n', "<leader>y", "\"+y")
vim.keymap.set("x", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
