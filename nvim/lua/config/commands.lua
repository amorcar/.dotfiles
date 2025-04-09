vim.api.nvim_create_user_command("Clearregs", function()
  local registers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"*+'
  for i = 1, #registers do
    local reg = registers:sub(i, i)
    vim.fn.setreg(reg, vim.fn.getreg("_"))
  end
  print("All registers cleared!")
end, { desc = "clear all registers" })
