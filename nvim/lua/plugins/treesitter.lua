-- treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    install_dir = vim.fn.stdpath("data") .. "/site",
    config = function()
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

      require("nvim-dap-repl-highlights").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
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
    end,
  },
}
