local M = {}

function M.setup()
  -- fugitive
  vim.keymap.set("n", "<leader>gG", ":G<CR>", { desc = "Git status fugitive (full)" })
  vim.keymap.set("n", "<leader>gg", ":G<CR><C-w>5-", { desc = "Git status (fugitive)" })

  -- gitsigns
  local gs = require("gitsigns")
  gs.setup()
  vim.keymap.set("n", "<leader>gbl", gs.blame_line, { desc = "Git blame line" })
  vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Git toggle inline blame" })
  vim.keymap.set("n", "<leader>ghi", gs.preview_hunk_inline, { desc = "Git hunk preview inline" })
  vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "Git hunk preview (float)" })
  vim.keymap.set("n", "]h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]h", bang = true })
    else
      gs.nav_hunk("next")
    end
  end, { desc = "Git next hunk" })

  vim.keymap.set("n", "[h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[h", bang = true })
    else
      gs.nav_hunk("prev")
    end
  end, { desc = "Git prev hunk" })

  -- diffview
  require("diffview").setup({
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff4_mixed",
        disable_diagnostics = false,
      },
    },
    hooks = {
      diff_buf_win_enter = function(bufnr, winid, ctx)
        if ctx.layout_name:match("^diff2") then
          if ctx.symbol == "a" then
            vim.opt_local.winhl = table.concat({
              "DiffAdd:DiffviewDiffAddAsDelete",
              "DiffDelete:DiffviewDiffDelete",
              "DiffChange:DiffAddAsDelete",
              "DiffText:DiffDeleteText",
            }, ",")
          elseif ctx.symbol == "b" then
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
  vim.keymap.set("n", "<leader>gdi", function()
    toggle_diffview("DiffviewOpen")
  end, { desc = "Git diff index (toggle)" })
  vim.keymap.set("n", "<leader>gdm", function()
    toggle_diffview("DiffviewOpen main..HEAD")
  end, { desc = "Git diff main (toggle)" })
  vim.keymap.set("n", "<leader>gdf", function()
    toggle_diffview("DiffviewFileHistory %")
  end, { desc = "Git diff file history" })
  vim.keymap.set("n", "<leader>gpr", function()
    toggle_diffview("DiffviewOpen origin/HEAD...HEAD")
  end, { desc = "Git PR review diff" })
  vim.keymap.set("n", "<leader>gpc", function()
    toggle_diffview("DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges")
  end, { desc = "Git PR review commits" })

  -- remote-line
  require("remote-line").setup({})
end

return M
