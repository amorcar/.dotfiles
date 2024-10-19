-- telescope
return {
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mollerhoj/telescope-recent-files.nvim",
    },
    config = function()
      local telescope_builtin = require("telescope.builtin")

      require("telescope").load_extension("recent-files")
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "bottom_pane",
          border = false,
          preview = false,
          layout_config = {
            bottom_pane = {
              height = 0.2,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "-L", "--files" },
          },
        },
        extensions = {
          recent_files = {
            only_cwd = true,
            show_current_file = false,
          },
        },
      })

      -- bindings
      vim.keymap.set("n", "<C-p>", function()
        require("telescope").extensions["recent-files"].recent_files({})
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
      vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles)
      vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers)
      vim.keymap.set("n", "<leader>fth", telescope_builtin.colorscheme)
      -- vim.keymap.set("n", "<leader>fbg", telescope_builtin.current_buffer_fuzzy_find)
      vim.keymap.set("n", "<leader>fc", telescope_builtin.commands)
      vim.keymap.set("n", "<leader>q", function()
        telescope_builtin.diagnostics({ bufnr = 0 })
      end)
      vim.keymap.set("n", "<leader>fds", telescope_builtin.lsp_document_symbols)
      vim.keymap.set("n", "<leader>fps", telescope_builtin.lsp_dynamic_workspace_symbols)
      -- vim.keymap.set("n", "<leader>gd", telescope_builtin.lsp_definitions)
      vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags)
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
