local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local expr = { expr = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal
-- Open and close all folds
keymap("n", "<leader>z", "zM", opts)
keymap("n", "<leader>Z", "zR", opts)

-- Search files
keymap("n", "<C-p>", ":Files<CR>", opts)

-- Search buffers
keymap("n", "<C-b>", ":Buffers<CR>", opts)

-- Search text in files
keymap("n", "<C-l>", ":Rg<CR>", opts)

-- Quick save
keymap("n", "<leader>w", ":w<CR>", opts)

-- Center search results in screen
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)

-- Very magic by default
-- keymap("n", "?", "?\v", opts)
-- keymap("n", "/", "/\v", opts)
-- keymap("n", "%s", "%sm/", opts)

-- Fix Y behaviour
keymap("n", "Y", "y$", opts)

-- Store realtive number jumps in jumplist
-- keymap("n", "<expr>k", "(v:count > 5 ? "m'" . v_count : "") . 'k'", opts)
-- keymap("n", "<expr>j", "(v:count > 5 ? "m'" . v_count : "") . 'j'", opts)

-- Stop search highlight
keymap("n", "<C-h>", ":nohlsearch<CR>", opts)

-- Edit init.lua
keymap("n", "<leader>ev", ":vsplit $MYVIMRC<CR>", opts)
-- Source init.lua
keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", opts)

-- Cicle buffers
keymap("n", "gb", ":bn<CR>", opts)
keymap("n", "gB", ":bp<CR>", opts)

-- Move by line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)


-- Insert --
-- Press jk fast instead of ESC
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stop search highlight
keymap("v", "<C-h>", ":nohlsearch<CR>", opts)
