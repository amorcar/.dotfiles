vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.opt.clipboard = "unnamedplus"

-- vim.opt.path:append("**")
vim.opt.grepprg = "rg --vimgrep"
vim.opt.timeoutlen = 4000
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2

vim.opt.wildmenu = true
vim.opt.wildmode = "noselect:longest:lastused,full"
vim.opt.wildoptions = "fuzzy"
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.colorcolumn = "80"
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
-- vim.opt.cmdwinheight = 1
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars:append({ fold = " " })
vim.opt.fillchars:append { diff = "╱" }
function _G.MyFoldText()
  return vim.fn.getline(vim.v.foldstart) .. " ... " .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
end

vim.opt.foldtext = "v:lua.MyFoldText()"
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append("iwhite")              -- better diffs (nvim -d) by ignoring whitespace
vim.opt.diffopt:append("algorithm:histogram") -- and using a smarter algorithm
vim.opt.diffopt:append("indent-heuristic")

vim.opt.exrc = true

--let g:tmux_navigator_disable_when_zoomed = 0
vim.cmd([[
  let g:tmux_navigator_no_mappings = 1
  set shell=/bin/zsh
]])
