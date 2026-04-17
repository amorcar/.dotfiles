-- Treesitter setup (eager: runs at startup)

-- treesitter
local ensure_installed = {
  "bash",
  "c",
  "dap_repl",
  "diff",
  "fish",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "html",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "rust",
  "sql",
  "terraform",
  "toml",
  "typescript",
  "vim",
  "yaml",
}

-- dap-repl-highlights must register its parser before treesitter install
require("nvim-dap-repl-highlights").setup()

require("nvim-treesitter").install(ensure_installed, { max_jobs = 8 })

-- Treesitter highlighting is built-in in 0.12 for installed parsers.
-- Only need a FileType autocmd for indentation (not built-in yet).
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterIndent", { clear = true }),
  desc = "Enable treesitter indentation",
  callback = function(event)
    local buf = event.buf
    local language = vim.treesitter.language.get_lang(event.match) or event.match
    if vim.treesitter.language.add(language) then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- treesitter-textobjects
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "V",
      ["@class.inner"] = "V",
    },
    include_surrounding_whitespace = false,
  },
})
vim.keymap.set({ "x", "o" }, "am", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "is", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)
