local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>yc", "yygccp", { noremap = true, desc = "duplicate and comment line" })

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", opts)
vim.keymap.set("n", "<leader>kb", "<cmd>bd<cr>", opts)
vim.keymap.set("n", "<leader>kt", "<cmd>tabc<cr>", opts)

-- toggles between buffers
-- vim.keymap.set("n", "<leader><leader>", "<c-^>", opts)

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

-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

-- include numbered movement into jumplist
vim.keymap.set("n", "k", [[(v:count > 1 ? "m'" . v:count : "g") . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 1 ? "m'" . v:count : "g") . 'j']], { expr = true })

-- escape terminal
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { silent = true })

-- move visual lines
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- a better J that keeps the cursor in the same place
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
vim.keymap.set("n", "[t", ":tprevious<cr>zz", opts)
vim.keymap.set("n", "]t", ":tnext<cr>zz", opts)
vim.keymap.set("n", "[T", ":tfirst<cr>zz", opts)
vim.keymap.set("n", "]T", ":tlast<cr>zz", opts)

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

-- on make, dont jump directly to the first quick list location
vim.keymap.set("n", "<leader>m", ":w | :make!<CR>", opts)

-- zooming split windows
vim.keymap.set("n", "Zz", "<c-w>_ | <c-w>|", opts)
vim.keymap.set("n", "Zo", "<c-w>=", opts)

-- easy git conflit selection
vim.keymap.set("n", "<leader>fc", "/<<<<CR>", opts)
vim.keymap.set("n", "<leader>gcu", "dd/|||<CR>0v/>>><CR>$x", opts)
vim.keymap.set("n", "<leader>gcb", "0v/|||<CR>$x/====<CR>0v/>>><CR>$x", opts)
vim.keymap.set("n", "<leader>gcs", "0v/====<CR>$x/>>><CR>dd", opts)

-- executing lua
vim.keymap.set("n", "<leader><leader>x", ":source %<cr>")
vim.keymap.set("n", "<leader>x", ":.lua<cr>")
vim.keymap.set("v", "<leader>x", ":lua<cr>")

-- close pretty much any buffer
vim.keymap.set("n", "Q", function()
	require("config.utils").smart_buffer_close({ quit_on_empty = false, prune_extra_wins = true })
end, { noremap = true, silent = true })
