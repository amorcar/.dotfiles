return {
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-speeddating" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_debug = 0
      vim.g.db_ui_force_echo_notifications = 1
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<M-w>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    "jpalardy/vim-slime",
    enabled = true,
    init = function()
      vim.g.slime_no_mappings = 1
    end,
    config = function()
      vim.cmd([[
        let g:slime_target = "tmux"
        let g:slime_bracketed_paste = 1
        let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
        let g:slime_dont_ask_default = 1

      ]])
      vim.g.slime_cell_delimiter = "#%%"
      vim.keymap.set("x", "<leader>s", "<Plug>SlimeRegionSend", { desc = "Slime send region" })
      vim.keymap.set("n", "<leader>s", "<Plug>SlimeMotionSend", { desc = "Slime send motion" })
      vim.keymap.set("n", "<leader>ss", "<Plug>SlimeLineSend", { desc = "Slime send line" })
      vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell", { desc = "Slime send cell" })
    end,
  },
}
