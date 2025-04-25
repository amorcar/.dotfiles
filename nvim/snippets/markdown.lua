local line_begin = require("luasnip.extras.expand_conditions").line_begin
return {
  s(
    { trig = "th", desc = "Insert current time", snippetType = "autosnippet" },
    { t("# "), t(vim.fn.strftime("%H:%M")), t({ "\n" }) },
    {}
  ),
}
