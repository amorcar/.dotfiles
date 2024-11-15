vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.opt.path:append("**")
vim.opt.timeoutlen = 4000
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2

vim.opt.undofile = true -- in ~/.local/state/nvim/undo/
vim.opt.wildmode = "list:longest,full"
vim.opt.wildoptions = "fuzzy,pum"
vim.opt.expandtab = true -- tabs as spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- show substitution targets

vim.opt.colorcolumn = "80" -- show a column at 80 characters as a guide for long lines
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
-- vim.opt.cmdwinheight = 1
vim.opt.laststatus = 0 -- always display the status line
vim.opt.ruler = false -- hide the ruler
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars:append({ fold = " " }) -- remove the whitespace symbols on fold text
function _G.MyFoldText()
	return vim.fn.getline(vim.v.foldstart) .. " ... " .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
end
vim.opt.foldtext = "v:lua.MyFoldText()"
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append("iwhite") -- better diffs (nvim -d) by ignoring whitespace
vim.opt.diffopt:append("algorithm:histogram") -- and using a smarter algorithm
vim.opt.diffopt:append("indent-heuristic")
