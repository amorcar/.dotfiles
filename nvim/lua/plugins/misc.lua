return {
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gof", ":G<CR>", {})
      vim.keymap.set("n", "<leader>gg", ":G<CR>", {})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup()
      vim.keymap.set("n", "<leader>gbl", gs.blame_line, {})
      vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, {})
      vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted, {})
      vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, {})
      vim.keymap.set("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          gs.nav_hunk("next")
        end
      end)

      vim.keymap.set("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[h", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end)
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<leader>god", ":DiffviewOpen<CR>", {})
    end,
  },
  {
    "NeogitOrg/neogit",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",      -- required
      "sindrets/diffview.nvim",     -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        kind = "split",
        disable_signs = true,
        disable_hint = true,
        graph_style = "unicode",
        commit_editor = {
          kind = "split",
          show_staged_diff = false,
          staged_diff_split_kind = "split",
          spell_check = true,
        },
      })
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", {})
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_execute_on_save = 1
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_winwidth = 35
      vim.g.db_ui_hide_schemas = { "pg_toast_temp.*" }
      vim.keymap.set("n", "<leader>dbt", ":DBUIToggle<cr>", { desc = "Toggle Dadbod UI" })
      vim.api.nvim_command("autocmd FileType dbui nmap <buffer> <tab> <Plug>(DBUI_SelectLine)")
    end,
  },
}
