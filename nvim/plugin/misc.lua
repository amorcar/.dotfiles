-- Tmux navigator, vim-slime, dadbod-ui keymaps (deferred: runs after VimEnter)
require("config.lazyload").on_vim_enter(function()
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

  -- vim-dadbod-ui keymaps
  vim.keymap.set("n", "<leader>Dtu", "<cmd>DBUIToggle<cr>", { desc = "Database toggle UI" })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql", "dbui", "dbout" },
    callback = function(ev)
      vim.keymap.set(
        "n",
        "<leader>De",
        "<Plug>(DBUI_ExecuteQuery)",
        { buffer = ev.buf, desc = "Database execute query" }
      )
      vim.keymap.set(
        "x",
        "<leader>De",
        "<Plug>(DBUI_ExecuteQuery)",
        { buffer = ev.buf, desc = "Database execute selection" }
      )
      vim.keymap.set(
        "n",
        "<leader>Dac",
        "<cmd>DBUIAddConnection<cr>",
        { buffer = ev.buf, desc = "Database add connection" }
      )
    end,
  })

  -- nvumi
  require("nvumi").setup({
    virtual_text = "newline", -- or "inline"
    prefix = " = ",         -- prefix shown before the output
    date_format = "iso",    -- or: "uk", "us", "long"
    width = 0.4,            -- 0–1 = fraction of terminal width, >1 = absolute columns
    height = 0.4,           -- 0–1 = fraction of terminal height, >1 = absolute lines
    keys = {
      run = "<CR>",         -- run/refresh calculations
      reset = "R",          -- reset buffer
      yank = "<leader>y",   -- yank output of current line
      yank_all = "<leader>Y", -- yank all outputs
    },
    -- see below for more on custom conversions/functions
    custom_conversions = {},
    custom_functions = {},
  })
  vim.keymap.set("n", "<leader>on", "<CMD>Nvumi<CR>", { desc = "Open nvumi" })
end)
