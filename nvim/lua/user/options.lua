local options = {
  -- backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  -- colorcolumn = 80,
  completeopt = { "menuone" },             -- mostly just for cmp
  expandtab = true,                        -- convert tabs to spaces
  fillchars = "vert:|",
  foldmethod = "syntax",
  foldlevel = 0,
  foldlevelstart = 99,
  formatoptions = "tc,r,q,n,b",
  ignorecase = true,                       -- ignore case in search patterns
  lazyredraw = true,
  list = true,
  listchars = "nbsp:¬,extends:»,precedes:«,trail:•",
  mouse = "a",                             -- allow the mouse to be used in neovim
  number = true,                           -- set numbered lines
  -- numberwidth = 2,                         -- set number column width to 2 {default 4}
  -- pumheight = 10,                          -- pop up menu height
  scrolloff = 2,                           -- is one of my fav
  shiftround = true,
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  shortmess = "filnxtToOFc",
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  sidescrolloff = 4,
  signcolumn = "number",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  synmaxcol = 150,
  tabstop = 2,                             -- insert 2 spaces for a tab
  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  -- updatetime = 300,                        -- faster completion (4000ms default)
  wildmode = "longest,list",
  wildignore = "*~,*.png,*.gif,*.jpg,Thumbs.db,*.swp,*.o,*.obj",
  whichwrap = "b,s,<,>,[,],h,l",
  wrap = false,                            -- display lines as one long line
  -- writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  secure = true
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

