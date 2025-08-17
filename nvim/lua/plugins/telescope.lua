-- telescope
return {
  {
    "nvim-telescope/telescope.nvim",
    -- name = "telescope",
    tag = "0.1.8",
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
            find_command = { "rg", "-L", "--no-config", "--files", "--sortr=modified" },
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
      end, { noremap = true, silent = true, desc = "open recent files" })
      -- vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "find files" })
      vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "find old files" })
      vim.keymap.set(
        "n",
        "<leader>fg",
        require("config.telescope.multigrep").live_multigrep,
        { desc = "find grep" }
      )
      vim.keymap.set("n", "<leader>fbo", telescope_builtin.buffers, { desc = "find buffers opened" })
      vim.keymap.set(
        "n",
        "<leader>fbg",
        telescope_builtin.current_buffer_fuzzy_find,
        { desc = "find buffers grep" }
      )
      vim.keymap.set("n", "<leader>q", function()
        telescope_builtin.diagnostics({ bufnr = 0 })
      end, { desc = "show diagnostics" })
      vim.keymap.set(
        "n",
        "<leader>fds",
        telescope_builtin.lsp_document_symbols,
        { desc = "find document symbols" }
      )
      vim.keymap.set(
        "n",
        "<leader>fps",
        telescope_builtin.lsp_dynamic_workspace_symbols,
        { desc = "find project symbols" }
      )
      -- vim.keymap.set("n", "<leader>gd", telescope_builtin.lsp_definitions)
      vim.keymap.set("n", "<leader>fvt", telescope_builtin.colorscheme, { desc = "find vim themes" })
      vim.keymap.set("n", "<leader>fvc", telescope_builtin.commands, { desc = "find vim commands" })
      vim.keymap.set("n", "<leader>fvh", telescope_builtin.help_tags, { desc = "find vim help pages" })
      vim.keymap.set("n", "<leader>fvm", telescope_builtin.marks, { desc = "find vim marks" })
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
  {
    "dmtrKovalenko/fff.nvim",
    enabled=true,
    build = "cargo build --release",
    opts = {
      ui_enabled = false,
      max_results = 10,
      max_threads=8,
      title = '',
      width = 1,
      height = 0.2,
      preview = {
        enabled = false,
      },
      prompt = "> ",
      icons = {
        enabled = false,
      },
      layout = {
        prompt_position = "top",
        height = 0.2,
        width = 1,
      },
      keymaps = {
        close = { '<Esc>', '<C-c>' },
        move_up = { '<Up>', '<C-p>', '<C-k>' },
        move_down = { '<Down>', '<C-n>', '<C-j>' }
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("fff").find_files()
        end,
        desc = "Open file picker",
      },
    },
  },
}
