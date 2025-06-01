vim.api.nvim_command("autocmd User FugitiveIndex nmap <buffer> <tab> =")
vim.api.nvim_command("autocmd User FugitiveIndex nmap <buffer> q <C-w>c")
vim.api.nvim_command("autocmd User FugitiveIndex nmap <buffer> PP :G push")
vim.api.nvim_create_autocmd("User", {
	pattern = "FugitiveIndex",
	callback = function()
		local arg = require("config.utils").branch_name()
		vim.keymap.set("n", "PU", ":G push --set-upstream origin " .. arg, { buffer = true })
	end,
})
