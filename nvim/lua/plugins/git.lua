return {
  {
    "tpope/vim-fugitive",
    enabled = true,
    config = function()
      vim.keymap.set("n", "<leader>gof", ":G<CR>", { desc = "git open fugitive" })
      vim.keymap.set("n", "<leader>gg", ":G<CR><C-w>5-", { desc = "git open fugitive" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup()
      vim.keymap.set("n", "<leader>gbl", gs.blame_line, { desc = "git blame line" })
      vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "git toogle blame" })
      vim.keymap.set("n", "<leader>gtd", gs.preview_hunk_inline, { desc = "git toggle delete" })
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
      require("diffview").setup({
        enhanced_diff_hl = true, -- closer to GitHub's web UI
        view = {
          merge_tool = {
            layout = "diff4_mixed",
            disable_diagnostics = false,
          },
        },
        hooks = {
          diff_buf_win_enter = function(bufnr, winid, ctx)
            -- if in the diff2 layout,
            if ctx.layout_name:match("^diff2") then
              -- set specific highlight groups for extra control
              if ctx.symbol == "a" then -- red colors always in the left hand buffer
                vim.opt_local.winhl = table.concat({
                  "DiffAdd:DiffviewDiffAddAsDelete",
                  "DiffDelete:DiffviewDiffDelete",
                  "DiffChange:DiffAddAsDelete",
                  "DiffText:DiffDeleteText",
                }, ",")
              elseif ctx.symbol == "b" then -- green colors in the right hand buffer
                vim.opt_local.winhl = table.concat({
                  "DiffDelete:DiffviewDiffDelete",
                  "DiffChange:DiffAdd",
                  "DiffText:DiffAddText",
                }, ",")
              end
            end
          end,
        },
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
      })
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
      vim.keymap.set("n", "<leader>gpr", function()
        toggle_diffview("DiffviewOpen origin/HEAD...HEAD")
      end, {
        desc = "Review PR diff",
      })
      vim.keymap.set("n", "<leader>gpc", function()
        toggle_diffview("DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges")
      end, {
        desc = "Review PR commit by commit",
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        kind = "split",
        disable_signs = true,
        disable_hint = true,
        disable_context_highlighting = true,
        graph_style = "unicode",
        commit_editor = {
          kind = "split",
          show_staged_diff = false,
          staged_diff_split_kind = "split",
          spell_check = true,
        },
        status = {
          show_head_commit_hash = false,
          HEAD_padding = 7,
          HEAD_folded = false,
          mode_padding = 3,
          mode_text = {
            M = "M",     -- modified
            N = "A",     -- new file
            A = "A",     -- added
            D = "D",     -- deleted
            C = "C",     -- copies
            U = "U",     -- updated
            R = "R",     -- renamed
            DD = "DD",   -- unmerged
            AU = "AU",   -- unmerged
            UD = "UD",   -- unmerged
            UA = "UA",   -- unmerged
            DU = "DU",   -- unmerged
            AA = "AA",   -- unmerged
            UU = "UU",   -- unmerged
            ["?"] = "?", -- untracked?
          },
        },
        mappings = {
          commit_editor = {
            ["q"] = "Close",
            ["<c-c><c-c>"] = false,
            ["<c-c><c-k>"] = false,
            ["<m-p>"] = false,
            ["<m-n>"] = false,
            ["<m-r>"] = false,
          },
          commit_editor_I = {
            ["<c-c><c-c>"] = false,
            ["<c-c><c-k>"] = false,
          },
          popup = {
            ["l"] = false,
            ["L"] = "LogPopup",
          },
        },
      })
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "open neogit" })
    end,
  },
}
