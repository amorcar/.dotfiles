-- Colorscheme setup (eager: runs at startup)

-- onenord
require("onenord").setup()

-- solarized
vim.o.background = "dark"
vim.o.termguicolors = true
require("solarized").setup({
  theme = "neo",
  palette = "solarized",
  variant = "autumn",
  styles = {
    comments = { italic = true, bold = true },
    functions = { italic = false },
    variables = { italic = false },
    types = {},
    parameters = {},
    strings = { italic = true },
    keywords = {},
    constants = {},
  },
  error_lens = {
    text = false,
    symbol = true,
  },
  plugins = {
    treesitter = true,
    lspconfig = true,
    neotree = true,
    whichkey = true,
    dashboard = true,
    gitsigns = true,
    telescope = true,
    lazy = true,
    gitgutter = true,
  },
  transparent = {
    enabled = true,
    pmenu = false,
    normal = false,
    normalfloat = false,
    telescope = true,
    lazy = false,
    mason = false,
  },
  on_highlights = function(colors, color)
    local lighten = color.lighten
    local shade = color.shade
    local groups = {
      Function = { fg = colors.base1 },
      DiagnosticUnderlineError = { fg = "" },
      DiagnosticUnderlineWarn = { fg = "" },
      DiagnosticUnderlineInfo = { fg = "" },
      DiagnosticUnderlineHint = { fg = "" },
      DiffAdd = { bg = "#0c4e53", fg = "" },
      DiffDelete = { bg = "#422d33", fg = "", reverse = false },
      DiffChange = { bg = shade("#204060", 2.5), fg = "" },
      DiffText = { bg = lighten("#204060", 2.5), fg = "", reverse = false },
    }
    return groups
  end,
})

-- kanagawa
require("kanagawa").setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,
  dimInactive = false,
  terminalColors = true,
  colors = {
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuExtra = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuExtraSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      PmenuKind = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuKindSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      DiffAdd = { bg = "#2b3328" },
      DiffDelete = { bg = "#43242b", fg = -1 },
      DiffAddAsDelete = { bg = "#43242b" },
      DiffAddText = { bg = "#2e4d22", fg = -1, bold = true },
      DiffDeleteText = { bg = "#6b2233", fg = -1 },
      DiffviewDiffDelete = { fg = "#16161d" },
      DiffviewDiffDeleteDim = { fg = "#32324a" },
    }
  end,
  theme = "wave",
  background = {
    dark = "wave",
    light = "lotus",
  },
})

-- kanso
require("kanso").setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = {},
  typeStyle = {},
  transparent = false,
  dimInactive = false,
  terminalColors = true,
  colors = {
    palette = {},
    theme = { zen = {}, pearl = {}, ink = {}, all = {} },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      DiffAdd = { bg = "#2b3328" },
      DiffDelete = { bg = "#43242b", fg = -1 },
      DiffviewDiffDelete = { fg = theme.ui.bg_dim },
      DiffviewDiffDeleteDim = { fg = theme.ui.shade_0 },
      DiffAddAsDelete = { bg = "#43242b" },
      DiffAddText = { bg = "#2e4d22", fg = "#d4d4d4", bold = true },
      DiffDeleteText = { bg = "#6b2233", fg = "#d4d4d4" },
    }
  end,
  theme = "zen",
  background = {
    dark = "zen",
    light = "pearl",
  },
})

-- e-ink
require("e-ink").setup()

-- Apply colorscheme (after all colorscheme plugins are configured)
vim.cmd.colorscheme("kanagawa-wave")
