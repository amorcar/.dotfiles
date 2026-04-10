local M = {}

function M.setup()
  -- neo-tree
  require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    default_component_configs = {
      icon = {
        enabled = true,
      },
      name = {
        trailing_slash = false,
      },
      indent = {
        indent_marker = " ",
        last_indent_marker = " ",
      },
    },
    window = {
      position = "left",
      width = 25,
    },
  })
  vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

  -- oil
  require("oil").setup({
    default_file_explorer = true,
    columns = {
      { "permissions", highlight = "Identifier" },
      { "size",        highlight = "String" },
      { "mtime",       highlight = "Special" },
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = true,
    constrain_cursor = "name",
    watch_for_changes = false,
    view_options = {
      show_hidden = false,
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
        return nil
      end,
    },
    keymaps = {
      ["gf"] = "actions.select",
      ["gp"] = "actions.preview",
      ["<C-p>"] = false, -- disable so it does not conflict w telescope
    },
  })
  vim.keymap.set("n", "<C->", "<CMD>10 sp|Oil<CR>", { desc = "Open parent directory" })
  -- complements built-in - (netrw parent dir); Oil replaces netrw
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return M
