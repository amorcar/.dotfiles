return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },

    config = function()
      local ls = require("luasnip")
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        ls.jump(-1)
      end, { silent = true })
      require("luasnip.loaders.from_lua").load({
        paths = { "./snippets/" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      -- Set up nvim-cmp.
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          -- disabled by default to avoid the anoying popups
          autocomplete = false,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        view = {
          entries = "native", -- can be "custom", "wildmenu" or "native"
        },
        window = {
          completion = cmp.config.window.bordered({ border = "" }),
          documentation = cmp.config.window.bordered({ border = "" }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-f>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 500 },
        }, {
          { name = "buffer", priority = 200 },
        }),
        experimental = { ghost_text = false },
      })

      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })
    end,
  },
}
