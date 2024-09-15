-------------------------------------------------------------------------------
-- keymaps
-------------------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

-- quick save
map("n", "<leader>w", "<cmd>w<cr>")
-- quick close buffer
map("n", "<leader>x", "<cmd>bd<cr>")

-- Ctrl+h to stop searching
map("v", "<C-h>", "<cmd>nohlsearch<cr>")
map("n", "<C-h>", "<cmd>nohlsearch<cr>")

-- <leader><leader> toggles between buffers
map("n", "<leader><leader>", "<c-^>")

-- always center search results
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })

-- center half-page jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- center jumplist jumps
-- map("n", "<C-o>", "<C-o>zz")
-- map("n", "<C-i>", "<C-i>zz")

-- "very magic" (less escaping needed) regexes by default
map("n", "?", "?\\v")
map("n", "/", "/\\v")
map("c", "%s/", "%sm/")

-- make j and k move by visual line, not actual line, when text is soft-wrapped
map("n", "j", "gj")
map("n", "k", "gk")

-- include numbered movement into jumplist
map('n', 'k', [[(v:count > 1 ? "m'" . v:count : "g") . 'k']], { expr = true })
map('n', 'j', [[(v:count > 1 ? "m'" . v:count : "g") . 'j']], { expr = true })

-- escape terminal
map("t", "<esc>", "<C-\\><C-n>", { silent = true })
map("t", "<C-w>", "<C-\\><C-n><C-w>", { silent = true })

-- move visual lines
-- map("x", "<C-J>", ":m '>+1<CR>gv=gv")
-- map("x", "<C-К>", ":m '<-2<CR>gv=gv")

-- a better J that keeps the cursor in the same place
map("n", "J", "mzJ`z")

-- leader yank to the system clipboard
map('n', "<leader>cy", "\"+y")
map("x", "<leader>cy", "\"+y")
map("n", "<leader>cY", "\"+Y")

-- buffer moves
map('n', "[b", ":bprevious<cr>")
map('n', "]b", ":bnext<cr>")
map('n', "[B", ":bfirst<cr>")
map('n', "]B", ":blast<cr>")

-- tab moves
map('n', "[t", ":tprevious<cr>")
map('n', "]t", ":tnext<cr>")
map('n', "[T", ":tfirst<cr>")
map('n', "]T", ":tlast<cr>")

-- quicklist moves
map('n', "[q", ":cprevious<cr>")
map('n', "]q", ":cnext<cr>")
map('n', "[Q", ":cfirst<cr>")
map('n', "]Q", ":clast<cr>")

-- location moves
map('n', "[l", ":lprevious<cr>")
map('n', "]l", ":lnext<cr>")
map('n', "[L", ":lfirst<cr>")
map('n', "]L", ":llast<cr>")

-- faster compilation
map("n", "<leader>m", ":w | :make<CR>")


-- zooming split windows
-- noremap Zz <c-w>_ \| <c-w>\|
-- noremap Zo <c-w>=
map('n', "Zz", "<c-w>_ | <c-w>|")
map('n', "Zo", "<c-w>=")
