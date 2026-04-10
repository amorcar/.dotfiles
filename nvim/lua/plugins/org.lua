local M = {}

function M.setup()
  -- obsidian
  require("obsidian").setup({
    legacy_commands = false,
    workspaces = {
      {
        name = "main",
        path = "~/.org/main/",
      },
    },
    notes_subdir = "notes/inbox",
    daily_notes = {
      folder = "notes/dailies",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = nil,
    },
    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    callbacks = {
      enter_note = function(note)
        vim.keymap.set("n", "<C-space>", require("obsidian.api").smart_action(), {
          buffer = true,
          desc = "Obsidian smart action",
        })
      end,
    },
    new_notes_location = "notes_subdir",
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.date("%Y%m%d%H%M%S")) .. "-" .. suffix
    end,
    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,
    frontmatter = {
      enabled = true,
      func = function(note)
        if note.title then
          note:add_alias(note.title)
        end
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      sort = { "id", "aliases", "tags" },
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
      },
    },
    picker = {
      name = "telescope.nvim",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },
    search = {
      sort_by = "accessed",
      sort_reversed = true,
      max_lines = 1000,
    },
    open_notes_in = "vsplit",
    ui = {
      enable = true,
      update_debounce = 200,
      max_file_length = 5000,
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
    checkbox = {
      enabled = true,
      create_new = true,
      order = { " ", "~", "!", ">", "x" },
    },
  })

  vim.keymap.set("n", "<localleader>onn", ":Obsidian new <cr>", { silent = true, desc = "Obsidian new note" })
  vim.keymap.set("n", "<localleader>ofn", ":Obsidian quick_switch <cr>", { silent = true, desc = "Obsidian quick switch" })
  vim.keymap.set("n", "<localleader>oft", ":Obsidian tags <cr>", { silent = true, desc = "Obsidian find tags" })
  vim.keymap.set("n", "<localleader>ood", ":Obsidian dailies -2 1<cr>", { silent = true, desc = "Obsidian dailies" })
  vim.keymap.set("n", "<localleader>opl", ":Obsidian links <cr>", { silent = true, desc = "Obsidian links" })
  vim.keymap.set("n", "<localleader>oen", ":Obsidian extract_note <cr>", { silent = true, desc = "Obsidian extract note" })
  vim.keymap.set("n", "<localleader>oat", ":Obsidian template <cr>", { silent = true, desc = "Obsidian template" })

  -- zen-mode
  require("zen-mode").setup({
    window = {
      backdrop = 0.95,
      width = 120,
      height = 1,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
      },
    },
  })
  vim.keymap.set("n", "<localleader>tz", ":ZenMode <cr>", { silent = true, desc = "Toggle zen mode" })
end

return M
