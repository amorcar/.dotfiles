local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>w<cr>", opts, opts)
map("n", "<leader>x", "<cmd>bd<cr>", opts, opts)

map("n", "<C-h>", "<cmd>nohlsearch<cr>", opts)

-- toggles between buffers
map("n", "<leader><leader>", "<c-^>", opts)

-- always center search results
map("n", "n", "nzz", { silent = true }, opts)
map("n", "N", "Nzz", { silent = true }, opts)
map("n", "*", "*zz", { silent = true }, opts)
map("n", "#", "#zz", { silent = true }, opts)
map("n", "g*", "g*zz", { silent = true }, opts)

-- center half-page jumps
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- center jumplist jumps
map("n", "<C-o>", "<C-o>zz", opts)
map("n", "<C-i>", "<C-i>zz", opts)

-- "very magic" (less escaping needed) regexes by default
-- map("n", "?", "?\\v")
-- map("n", "/", "/\\v")
-- map("c", "%s/", "%sm/")

-- make j and k move by visual line, not actual line, when text is soft-wrapped
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- include numbered movement into jumplist
map("n", "k", [[(v:count > 1 ? "m'" . v:count : "g") . 'k']], { expr = true }, opts)
map("n", "j", [[(v:count > 1 ? "m'" . v:count : "g") . 'j']], { expr = true }, opts)

-- escape terminal
map("t", "<esc>", "<C-\\><C-n>", { silent = true }, opts)
map("t", "<C-w>", "<C-\\><C-n><C-w>", { silent = true }, opts)

-- move visual lines
map("v", "J", ":m '>+1<CR>gv=gv", opts, opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts, opts)

-- a better J that keeps the cursor in the same place
map("n", "J", "mzJ`z", opts)

-- clipboard yank
map("n", "<leader>cy", '"+y', opts)
map("x", "<leader>cy", '"+y', opts)
map("n", "<leader>cY", '"+Y', opts)

-- buffer moves
map("n", "[b", ":bprevious<cr>zz", opts)
map("n", "]b", ":bnext<cr>zz", opts)
map("n", "[B", ":bfirst<cr>zz", opts)
map("n", "]B", ":blast<cr>zz", opts)

-- tab moves
map("n", "[t", ":tprevious<cr>zz", opts)
map("n", "]t", ":tnext<cr>zz", opts)
map("n", "[T", ":tfirst<cr>zz", opts)
map("n", "]T", ":tlast<cr>zz", opts)

-- quicklist moves
map("n", "[q", ":cprevious<cr>zz", opts)
map("n", "]q", ":cnext<cr>zz", opts)
map("n", "[Q", ":cfirst<cr>zz", opts)
map("n", "]Q", ":clast<cr>zz", opts)

-- location moves
map("n", "[l", ":lprevious<cr>zz", opts)
map("n", "]l", ":lnext<cr>zz", opts)
map("n", "[L", ":lfirst<cr>zz", opts)
map("n", "]L", ":llast<cr>zz", opts)

-- changelist
map("n", "[g", "g;zz", opts)
map("n", "]g", "g,zz", opts)
map("n", "[G", "999g,zz", opts)
map("n", "]G", "999g;zz", opts)

-- dont jump directly to the first quick list location
map("n", "<leader>m", ":w | :make!<CR>", opts)

-- zooming split windows
map("n", "Zz", "<c-w>_ | <c-w>|", opts)
map("n", "Zo", "<c-w>=", opts)
