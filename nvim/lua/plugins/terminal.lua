local M = {}

function M.setup()
  require("toggleterm").setup({
    shell = '/opt/homebrew/bin/fish',
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,

    open_mapping = [[<c-\>]],

    shade_terminals = false,
    shading_factor = "-10",
    shading_ratio = "-3",

    direction = "horizontal",
  })
end

return M
