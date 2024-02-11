-- telescope
return {
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope_builtin = require("telescope.builtin")

      -- bindings
      vim.keymap.set("n", "<C-p>", telescope_builtin.find_files)
      vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles)
      vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers)
      vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
      vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
      vim.keymap.set("n", "<leader>fth", telescope_builtin.colorscheme)
      vim.keymap.set("n", "<leader>fbg", telescope_builtin.current_buffer_fuzzy_find)
      -- lsp
      vim.keymap.set("n", "<leader>q", telescope_builtin.diagnostics)
      vim.keymap.set("n", "<leader>fds", telescope_builtin.lsp_document_symbols)
      -- vim.keymap.set("n", "<leader>gd", telescope_builtin.lsp_definitions)
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
