return {
  { "tpope/vim-surround" },

  { "tpope/vim-commentary" },
  -- git
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup()
      vim.keymap.set("n", "<leader>hbl", gs.blame_line, {})
      vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, {})
      vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, {})
      vim.keymap.set("n", "<leader>hsd", gs.preview_hunk, {})
      -- vim.keymap.set('n', '<leader>hsD', gs.diffthis, {})
      vim.keymap.set("n", "[c", gs.prev_hunk, {})
      vim.keymap.set("n", "]c", gs.next_hunk, {})
    end,
  },
  {
    "samharju/yeet.nvim",
    dependencies = {
      "stevearc/dressing.nvim", -- optional, provides sane UX
    },
    version = "*",           -- update only on releases
    cmd = "Yeet",
    opts = {
      -- Send <CR> to channel after command for immediate execution.
      yeet_and_run = true,
      -- Send C-c before execution
      interrupt_before_yeet = false,
      -- Send 'clear<CR>' to channel before command for clean output.
      clear_before_yeet = true,
      -- Enable notify for yeets. Success notifications may be a little
      -- too much if you are using noice.nvim or fidget.nvim
      notify_on_success = true,
      -- Print warning if pane list could not be fetched, e.g. tmux not running.
      warn_tmux_not_running = false,
    },

    keys = {
        {
            -- Pop command cache open
            "<leader>yc",
            function() require("yeet").list_cmd() end,
        },
        {
            -- Open target selection
            "<leader>yt", function() require("yeet").select_target() end,
        },
        {
            -- Douple tap \ to yeet at something
            "<leader>yy", function() require("yeet").execute() end,
        },
        {
            -- Toggle autocommand for yeeting after write
            "<leader>yo", function() require("yeet").toggle_post_write() end,
        },
        {
            -- Run command without clearing terminal, send C-c
            "<leader>yn", function()
                require("yeet").execute(nil, { clear_before_yeet = false, interrupt_before_yeet = true })
            end,
        },
        {
            -- Yeet visual selection. Useful sending core to a repl or running multiple commands.
            "<leader>yv",
                function() require("yeet").execute_selection({ clear_before_yeet = false }) end,
            mode = { "n", "v" },
        },
    },
  },
}
