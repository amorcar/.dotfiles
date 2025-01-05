return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    enabled = true,
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 20
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,

        open_mapping = [[<c-\>]],

        shade_terminals = false,
        shading_factor = "-10", -- the percentage by which to lighten dark terminal background, default: -30
        shading_ratio = "-3", -- the ratio of shading factor for light/dark terminal background, default: -3

        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float',
      })

      -- local Terminal = require("toggleterm.terminal").Terminal
      -- local btop = Terminal:new({
      --   cmd = "btop",
      --   hidden = true,
      --   direction = 'horizontal'
      -- })

      -- function _btop_toggle()
      --   btop:toggle()
      -- end

      -- vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua _btop_toggle()<CR>", { noremap = true, silent = true })
    end,
  },
}
