return {
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gof", ":G<CR>", { desc = "git open fugitive" })
      vim.keymap.set("n", "<leader>gg", ":G<CR>", { desc = "git open fugitive" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup()
      vim.keymap.set("n", "<leader>gbl", gs.blame_line, { desc = "git blame line" })
      vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "git toogle blame" })
      vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted, { desc = "git toggle delete" })
      vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "git hunk preview" })
      vim.keymap.set("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, { desc = "next hunk" })

      vim.keymap.set("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[h", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, { desc = "prev hunk" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    command = "DiffviewOpen",
    config = function()
      local function toggle_diffview(cmd)
        if next(require("diffview.lib").views) == nil then
          vim.cmd(cmd)
        else
          vim.cmd("DiffviewClose")
        end
      end
      vim.keymap.set("n", "<leader>gd", function()
        toggle_diffview("DiffviewOpen")
      end, { desc = "diff index" })
      vim.keymap.set("n", "<leader>gD", function()
        toggle_diffview("DiffviewOpen main..HEAD")
      end, { desc = "diff main" })
      vim.keymap.set("n", "<leader>gf", function()
        toggle_diffview("DiffviewFileHistory %")
      end, { desc = "Open diffs for current File" })
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
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "open neogit" })
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
    config = function()
      vim.cmd([[
        let g:tmux_navigator_no_mappings = 1
        let g:tmux_navigator_disable_when_zoomed = 1
      ]])
    end,
  },
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      view = {
        display_mode = "border",
      },
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
      require("overseer").setup({
        strategy = "terminal",
        -- load your default shell before starting the task
        use_shell = true,
        -- have the toggleterm window close and delete the terminal buffer
        -- automatically after the task exits
        close_on_exit = false,
        -- have the toggleterm window close without deleting the terminal buffer
        -- automatically after the task exits
        -- can be "never, "success", or "always". "success" will close the window
        -- only if the exit code is 0.
        quit_on_exit = "success",
      })

      vim.api.nvim_create_user_command("Grep", function(params)
        -- Insert args at the '$*' in the grepprg
        local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
        if num_subs == 0 then
          cmd = cmd .. " " .. params.args
        end
        local task = require("overseer").new_task({
          cmd = vim.fn.expandcmd(cmd),
          components = {
            {
              "on_output_quickfix",
              errorformat = vim.o.grepformat,
              open = not params.bang,
              open_height = 8,
              items_only = true,
            },
            -- We don't care to keep this around as long as most tasks
            { "on_complete_dispose", timeout = 30 },
            "default",
          },
        })
        task:start()
      end, { nargs = "*", bang = true, complete = "file" })
    end,
  },
}
