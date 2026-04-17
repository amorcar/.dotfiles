-- Telescope pickers and keymaps (deferred: runs after VimEnter)
require("config.lazyload").on_vim_enter(function()
  local telescope_builtin = require("telescope.builtin")

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
        find_command = { "rg", "-L", "--no-config", "--files", "--sortr=modified" },
      },
    },
    extensions = {
      recent_files = {
        only_cwd = true,
        show_current_file = false,
      },
      ui_select = {
        specific_opts = {
          codeactions = false,
        },
      },
    },
  })

  require("telescope").load_extension("recent-files")
  require("telescope").load_extension("ui-select")

  vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<C-p>", function()
    require("telescope").extensions["recent-files"].recent_files()
  end, { desc = "Find recent files" })
  vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fbs", telescope_builtin.lsp_document_symbols, { desc = "Find buffer symbols" })
  vim.keymap.set("n", "<leader>fps", telescope_builtin.lsp_dynamic_workspace_symbols, { desc = "Find project symbols" })
  vim.keymap.set("n", "<leader>fgp", telescope_builtin.live_grep, { desc = "Find grep project" })
  vim.keymap.set("n", "<leader>fgb", telescope_builtin.current_buffer_fuzzy_find, { desc = "Find grep in buffer" })
  vim.keymap.set("n", "<leader>fgw", telescope_builtin.grep_string, { desc = "Find grep word under cursor" })
  vim.keymap.set("n", "<leader>fvt", telescope_builtin.colorscheme, { desc = "Find vim themes" })
  vim.keymap.set("n", "<leader>fvc", telescope_builtin.commands, { desc = "Find vim commands" })
  vim.keymap.set("n", "<leader>fvh", telescope_builtin.help_tags, { desc = "Find vim help" })
  vim.keymap.set("n", "<leader>fvm", telescope_builtin.marks, { desc = "Find vim marks" })
end)
