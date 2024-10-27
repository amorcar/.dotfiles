return {
  { "tpope/vim-surround" },

  { "tpope/vim-commentary" },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>hos", ":G<CR>", {})
    end,
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
    "sindrets/diffview.nvim",
    config = function()
      local diffview = require("diffview")
      vim.keymap.set("n", "<leader>hod", ":DiffviewOpen<CR>", {})
    end,
  },
}
