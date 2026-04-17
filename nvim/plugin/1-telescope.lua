-- Telescope, fff.nvim pickers and keymaps (deferred: runs after VimEnter)
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

  -- <C-p>, <leader>ff, <leader>fgp, <leader>fgz, <leader>fgw are mapped by fff.nvim below
  vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fbs", telescope_builtin.lsp_document_symbols, { desc = "Find buffer symbols" })
  vim.keymap.set("n", "<leader>fps", telescope_builtin.lsp_dynamic_workspace_symbols, { desc = "Find project symbols" })
  vim.keymap.set("n", "<leader>fvt", telescope_builtin.colorscheme, { desc = "Find vim themes" })
  vim.keymap.set("n", "<leader>fvc", telescope_builtin.commands, { desc = "Find vim commands" })
  vim.keymap.set("n", "<leader>fvh", telescope_builtin.help_tags, { desc = "Find vim help" })
  vim.keymap.set("n", "<leader>fvm", telescope_builtin.marks, { desc = "Find vim marks" })

  -- fff.nvim
  require("fff").setup({
    max_results = 30,
    max_threads = 8,
  })
  local ok, _ = pcall(function() require("fff.core").ensure_initialized() end)
  if not ok then
    vim.notify("fff.nvim: binary not found. Run :lua require('fff.download').download_or_build_binary() then restart.", vim.log.levels.WARN)
  end

  local function fff_telescope_picker(title)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local fuzzy = require("fff.core").ensure_initialized()
    local fff_config = require("fff.conf").get()

    pickers.new({}, {
      prompt_title = title or "fff",
      finder = finders.new_dynamic({
        fn = function(prompt)
          local ok, result = pcall(
            fuzzy.fuzzy_search_files,
            prompt or "",
            30,
            fff_config.max_threads or 8,
            0,
            0
          )
          if ok and result and result.items then
            return result.items
          end
          return {}
        end,
        entry_maker = function(item)
          return {
            value = item,
            display = item.relative_path,
            ordinal = item.relative_path,
            path = item.path,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          if entry then
            vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
          end
        end)
        return true
      end,
    }):find()
  end

  local function fff_telescope_grep(title, grep_mode, initial_query)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local grep = require("fff.grep")
    local grep_config = require("fff.conf").get().grep or {}

    pickers.new({}, {
      prompt_title = title or "fff grep",
      default_text = initial_query or "",
      finder = finders.new_dynamic({
        fn = function(prompt)
          if not prompt or prompt == "" then return {} end
          local result = grep.search(prompt, 0, 50, grep_config, grep_mode or "plain")
          if result and result.items then
            return result.items
          end
          return {}
        end,
        entry_maker = function(item)
          local display = string.format(
            "%s:%d: %s",
            item.relative_path or item.path,
            item.line_number or 0,
            item.line_content or ""
          )
          return {
            value = item,
            display = display,
            ordinal = display,
            filename = item.path,
            lnum = item.line_number or 1,
            col = (item.col or 0) + 1,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          if entry then
            vim.cmd("edit " .. vim.fn.fnameescape(entry.filename))
            vim.api.nvim_win_set_cursor(0, { entry.lnum, entry.col - 1 })
          end
        end)
        return true
      end,
    }):find()
  end

  vim.keymap.set("n", "<leader>ff", function() fff_telescope_picker("Find files") end,
    { desc = "Find files" })
  vim.keymap.set("n", "<C-p>", function() fff_telescope_picker("Find files") end,
    { desc = "Find files" })
  vim.keymap.set("n", "<leader>fgp", function() fff_telescope_grep("Grep") end,
    { desc = "Find grep project" })
  vim.keymap.set("n", "<leader>fgb", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
  end, { desc = "Find grep in buffer" })
  vim.keymap.set("n", "<leader>fgz", function() fff_telescope_grep("Fuzzy grep", "fuzzy") end,
    { desc = "Find grep fuzzy" })
  vim.keymap.set("n", "<leader>fgr", function() fff_telescope_grep("Regex grep", "regex") end,
    { desc = "Find grep regex" })
  vim.keymap.set("n", "<leader>fgw", function()
    fff_telescope_grep("Grep word", "plain", vim.fn.expand("<cword>"))
  end, { desc = "Find grep word under cursor" })
end)
