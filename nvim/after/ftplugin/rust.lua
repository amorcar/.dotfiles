vim.opt_local.shiftwidth = 4
vim.opt_local.colorcolumn = "100"

-- shadows built-in gra (code action); uses rust-analyzer's grouping instead
vim.keymap.set(
  "n",
  "gra",
  function()
    vim.cmd.RustLsp('codeAction')
  end,
  { silent = true, buffer = 0, desc = "Rust code action (grouped)" }
)
-- shadows built-in K (hover); uses rustaceanvim's hover actions instead
vim.keymap.set(
  "n",
  "K",
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, buffer = 0, desc = "Rust hover actions" }
)
