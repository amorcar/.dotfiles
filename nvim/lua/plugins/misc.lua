local M = {}

-- Globals that must be set BEFORE plugins load
function M.pre_setup()
  -- vim-tmux-navigator
  vim.g.tmux_navigator_no_mappings = 1
  vim.g.tmux_navigator_disable_when_zoomed = 1

  -- vim-slime
  vim.g.slime_no_mappings = 1

  -- vim-dadbod-ui
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_execute_on_save = 0
  vim.g.db_ui_debug = 0
  vim.g.db_ui_force_echo_notifications = 1
end

function M.setup()
  -- vim-tmux-navigator keymaps
  vim.keymap.set("n", "<M-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux navigate left" })
  vim.keymap.set("n", "<M-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux navigate down" })
  vim.keymap.set("n", "<M-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux navigate up" })
  vim.keymap.set("n", "<M-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux navigate right" })
  vim.keymap.set("n", "<M-w>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux navigate previous" })

  -- vim-slime
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
end

return M
