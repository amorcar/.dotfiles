-- treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-dap-repl-highlights").setup()
      local ts_configs = require("nvim-treesitter.configs")
      ts_configs.setup({
        ensure_installed = {
          "c",
          "json",
          "lua",
          "markdown",
          "python",
          "rust",
          "sql",
          "terraform",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "dap_repl",
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- defined in textobjects.scm
              ["af"] = { query = "@function.outer", desc = "around function" },
              ["if"] = { query = "@function.inner", desc = "in function" },
              ["ac"] = { query = "@class.outer", desc = "around class" },
              ["ic"] = { query = "@class.inner", desc = "in class" },
              ["ab"] = { query = "@block.outer", desc = "around block" },
              ["ib"] = { query = "@block.inner", desc = "in block" },
              ["is"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "V",
              ["@class.inner"] = "V",
            },
            include_surrounding_whitespace = false,
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    depends = { "nvim-treesitter/nvim-treesitter" },
  },
}
