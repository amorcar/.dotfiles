-- treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
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
        -- "html",
        "json",
        "lua",
        "make",
        "markdown",
        -- "markdown_inline",
        "python",
        "regex",
        "rust",
        "sql",
        "terraform",
        "toml",
        -- "typescript",
        "vim",
        "yaml",
      }

      require("nvim-treesitter").install(ensure_installed, { max_jobs = 8 })

      local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
      -- Enable highlighting on FileType
      vim.api.nvim_create_autocmd("FileType", {
        -- pattern = { "<filetype>" },
        group = group,
        desc = "Enable treesitter highlighting and indentation",
        callback = function(event)
          local buf = event.buf
          local filetype = event.match

          local language = vim.treesitter.language.get_lang(filetype) or filetype
          -- if not vim.tbl_contains(ensure_installed, event.match) then
          --   return
          -- end
          if not vim.treesitter.language.add(language) then
            return
          end

          -- Start highlighting immediately (works if parser exists)
          -- vim.treesitter.start()
          -- pcall(vim.treesitter.start, buf, lang)
          vim.treesitter.start(buf, language)

          -- Enable treesitter indentation
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Folding
          -- vim.wo[0][0].foldmethod = "expr"
          -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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
