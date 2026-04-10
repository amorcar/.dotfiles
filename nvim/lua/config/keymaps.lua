local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>yc", "yygccp", { remap = true, desc = "Duplicate and comment line" })

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>bc", "<cmd>bd<cr>", { noremap = true, silent = true, desc = "Buffer close" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabc<cr>", { noremap = true, silent = true, desc = "Tab close" })

-- always center search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })

-- center half-page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- center jumplist jumps
vim.keymap.set("n", "<C-o>", "<C-o>zz", opts)
vim.keymap.set("n", "<C-i>", "<C-i>zz", opts)

-- "very magic" (less escaping needed) regexes by default
-- vim.keymap.set("n", "?", "?\\v")
-- vim.keymap.set("n", "/", "/\\v")
-- vim.keymap.set("c", "%s/", "%sm/")

-- include numbered movement into jumplist (also uses gj/gk for visual line movement)
vim.keymap.set("n", "k", [[(v:count > 1 ? "m'" . v:count : "g") . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 1 ? "m'" . v:count : "g") . 'j']], { expr = true })

-- escape terminal
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { silent = true })

-- move visual lines
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- shadows built-in J (join lines); this version preserves cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- clipboard yank
-- vim.keymap.set("n", "<leader>cy", '"+y', opts)
-- vim.keymap.set("x", "<leader>cy", '"+y', opts)
-- vim.keymap.set("n", "<leader>cY", '"+Y', opts)

-- buffer moves
vim.keymap.set("n", "[b", ":bprevious<cr>zz", opts)
vim.keymap.set("n", "]b", ":bnext<cr>zz", opts)
vim.keymap.set("n", "[B", ":bfirst<cr>zz", opts)
vim.keymap.set("n", "]B", ":blast<cr>zz", opts)

-- tab moves
vim.keymap.set("n", "[t", ":tabprevious<cr>zz", opts)
vim.keymap.set("n", "]t", ":tabnext<cr>zz", opts)
vim.keymap.set("n", "[T", ":tabfirst<cr>zz", opts)
vim.keymap.set("n", "]T", ":tablast<cr>zz", opts)

-- quicklist moves
vim.keymap.set("n", "[c", ":cprevious<cr>zz", opts)
vim.keymap.set("n", "]c", ":cnext<cr>zz", opts)
vim.keymap.set("n", "[C", ":cfirst<cr>zz", opts)
vim.keymap.set("n", "]C", ":clast<cr>zz", opts)

-- location moves
vim.keymap.set("n", "[l", ":lprevious<cr>zz", opts)
vim.keymap.set("n", "]l", ":lnext<cr>zz", opts)
vim.keymap.set("n", "[L", ":lfirst<cr>zz", opts)
vim.keymap.set("n", "]L", ":llast<cr>zz", opts)

-- changelist
vim.keymap.set("n", "[g", "g;zz", opts)
vim.keymap.set("n", "]g", "g,zz", opts)
vim.keymap.set("n", "[G", "999g,zz", opts)
vim.keymap.set("n", "]G", "999g;zz", opts)

-- zooming split windows
vim.keymap.set("n", "Zz", "<c-w>_ | <c-w>|", opts)
vim.keymap.set("n", "Zo", "<c-w>=", opts)

-- git conflict selection
vim.keymap.set("n", "<leader>fc", "/<<<<CR>", { noremap = true, silent = true, desc = "Find git conflict marker" })
vim.keymap.set("n", "<leader>gcu", "dd/|||<CR>0v/>>><CR>$x", { noremap = true, silent = true, desc = "Git conflict use upstream" })
vim.keymap.set("n", "<leader>gcb", "0v/|||<CR>$x/====<CR>0v/>>><CR>$x", { noremap = true, silent = true, desc = "Git conflict use both" })
vim.keymap.set("n", "<leader>gcs", "0v/====<CR>$x/>>><CR>dd", { noremap = true, silent = true, desc = "Git conflict use self" })

-- executing lua
vim.keymap.set("n", "<leader><leader>x", ":source %<cr>", { desc = "Source current file" })

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Open undotree" })

-- shadows built-in Q (Ex mode)
vim.keymap.set("n", "Q", function()
	require("config.utils").smart_buffer_close({ quit_on_empty = false, prune_extra_wins = true })
end, { noremap = true, silent = true, desc = "Smart close buffer" })
