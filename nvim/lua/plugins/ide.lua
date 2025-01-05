return {
  "ldelossa/nvim-ide",
  enabled = false,
  name = "nvim-ide",
  lazy = true,
  config = function()
    -- default components
    local bufferlist = require("ide.components.bufferlist")
    local explorer = require("ide.components.explorer")
    local outline = require("ide.components.outline")
    local callhierarchy = require("ide.components.callhierarchy")
    local timeline = require("ide.components.timeline")
    local terminal = require("ide.components.terminal")
    local terminalbrowser = require("ide.components.terminal.terminalbrowser")
    local changes = require("ide.components.changes")
    local commits = require("ide.components.commits")
    local branches = require("ide.components.branches")
    local bookmarks = require("ide.components.bookmarks")

    require("ide").setup({
      -- default panel groups to display on left and right.
      panels = {
        left = "explorer",
        right = "git",
      },
      -- panels defined by groups of components, user is free to redefine the defaults
      -- and/or add additional.
      panel_groups = {
        explorer = {
          outline.Name,
          bufferlist.Name,
          explorer.Name,
          bookmarks.Name,
          callhierarchy.Name,
          terminalbrowser.Name,
        },
        terminal = { terminal.Name },
        git = { changes.Name, commits.Name, timeline.Name, branches.Name },
      },
    })
  end,
}
