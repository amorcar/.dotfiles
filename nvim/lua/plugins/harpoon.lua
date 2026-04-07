local M = {}

function M.setup()
  local harpoon = require("harpoon")
  harpoon:setup({
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  })

  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end
    require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
  end

  local map = vim.keymap.set

  map("n", "<leader>hh", function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), {
      border = "none",
      title = "",
    })
  end, { desc = "Harpoon quick menu" })
  map("n", "<leader>hf", function()
    toggle_telescope(harpoon:list())
  end, { desc = "Harpoon find (telescope)" })
  map("n", "<leader>ha", function()
    harpoon:list():add()
  end, { desc = "Harpoon: add buffer" })
  map("n", "<leader>h1", function()
    harpoon:list():select(1)
  end, { desc = "Harpoon: buffer 1" })
  map("n", "<leader>h2", function()
    harpoon:list():select(2)
  end, { desc = "Harpoon: buffer 2" })
  map("n", "<leader>h3", function()
    harpoon:list():select(3)
  end, { desc = "Harpoon: buffer 3" })
  map("n", "<leader>h4", function()
    harpoon:list():select(4)
  end, { desc = "Harpoon: buffer 4" })
end

return M
