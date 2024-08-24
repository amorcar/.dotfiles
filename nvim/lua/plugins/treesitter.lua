-- treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  name = "treesitter",
  build = ":TSUpdate",
  config = function()
    local ts_configs = require("nvim-treesitter.configs")
    ts_configs.setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "python",
        "rust",
        "typescript",
        "terraform",
        "json",
        "yaml",
        "toml",
        "markdown",
        "c",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
