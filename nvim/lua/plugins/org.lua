-- note taking in vim
return {
  "nvim-neorg/neorg",
  name = "neorg",
  enable = true,
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              main = "~/.norg/main",
            },
            default_workspace = "main",
            index = "index.norg",
          },
        },
        ["core.journal"] = {
          config = {
            workspace = "main"
          },
        },
        ["core.esupports.metagen"] = {
          config = {
            author = "amorales",
          },
        },
        ["core.summary"] = {
          config = {
            strategy = "by_path", -- by_path
          },
        },
        ["core.concealer"] = {
          config = {
            icons = {
              delimiter = {
                horizontal_line = {
                  highlight = "@neorg.delimiters.horizontal_line",
                },
              },
              code_block = {
                -- If true will only dim the content of the code block (without the
                -- `@code` and `@end` lines), not the entirety of the code block itself.
                content_only = true,

                -- The width to use for code block backgrounds.
                -- When set to `fullwidth` (the default), will create a background
                -- that spans the width of the buffer.
                -- When set to `content`, will only span as far as the longest line
                -- within the code block.
                width = "fullwidth",

                -- Additional padding to apply to either the left or the right. Making
                -- these values negative is considered undefined behaviour (it is
                -- likely to work, but it's not officially supported).
                padding = {
                  left = 20,
                  right = 20,
                },

                -- If `true` will conceal (hide) the `@code` and `@end` portion of the code
                -- block.
                conceal = true,

                nodes = { "ranged_verbatim_tag" },
                highlight = "CursorLine",
                -- render = module.public.icon_renderers.render_code_block,
                insert_enabled = true,
              },
            },
          },
        },
      },
    })
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2

    -- keybinds
    vim.keymap.set("n", "<localleader>ni", ":Neorg index<CR>", {})
  end,
}
