require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.commands")
require("config.pack")
require("config.quickfix")
require("config.find")

vim.cmd.colorscheme("kanagawa-wave")

-- Built-in optional plugins
vim.cmd.packadd("nvim.undotree")
