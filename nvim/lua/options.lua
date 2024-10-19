-------------------------------------------------------------------------------
-- general options
-------------------------------------------------------------------------------

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.g.maplocalleader = ";"

vim.opt.timeoutlen = 4000

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.scrolloff = 2

vim.opt.signcolumn = "yes"

vim.opt.conceallevel = 2

-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true

vim.opt.wildmode = ""
-- don't suggest files like:
vim.opt.wildignore = "*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,"

vim.opt.path:append("**")

-- tabs as spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true

vim.opt.inccommand = "split"

-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

-- vim.opt.cmdwinheight = 1

vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars:append({ fold = " " }) -- remove the whitespace symbols on fold text

function _G.MyFoldText()
	return vim.fn.getline(vim.v.foldstart) .. " ... " .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
end

vim.opt.foldtext = "v:lua.MyFoldText()"
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

--- better diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append("iwhite")
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")

