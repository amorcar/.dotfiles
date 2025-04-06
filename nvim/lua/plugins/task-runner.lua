-- task runner related plugins
return {
	{
		"stevearc/overseer.nvim",
		opts = {},
		config = function()
			require("overseer").setup({
				strategy = "terminal",
				-- load your default shell before starting the task
				use_shell = true,
				-- have the toggleterm window close and delete the terminal buffer
				-- automatically after the task exits
				close_on_exit = false,
				-- have the toggleterm window close without deleting the terminal buffer
				-- automatically after the task exits
				-- can be "never, "success", or "always". "success" will close the window
				-- only if the exit code is 0.
				quit_on_exit = "never",
			})

			-- related keymaps
			vim.keymap.set("n", "<leader>oo", ":OverseerToggle<CR>", { noremap = true, desc = "Toggle Overseer" })
			vim.keymap.set("n", "<leader>or", ":OverseerRun<CR>", { noremap = true, desc = "Run an Overseer task" })

			-- Asynchronous :Grep command
			vim.api.nvim_create_user_command("Grep", function(params)
				-- Insert args at the '$*' in the grepprg
				local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = require("overseer").new_task({
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{
							"on_output_quickfix",
							errorformat = vim.o.grepformat,
							open = not params.bang,
							open_height = 8,
							items_only = true,
						},
						-- We don't care to keep this around as long as most tasks
						{ "on_complete_dispose", timeout = 30 },
						"default",
					},
				})
				task:start()
			end, { nargs = "*", bang = true, complete = "file" })
		end,

		-- :Make similar to vim-dispatch
		vim.api.nvim_create_user_command("Make", function(params)
			-- Insert args at the '$*' in the makeprg
			local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
			if num_subs == 0 then
				cmd = cmd .. " " .. params.args
			end
			local task = require("overseer").new_task({
				cmd = vim.fn.expandcmd(cmd),
				components = {
					{ "on_output_quickfix", open = not params.bang, open_height = 8 },
					"default",
				},
			})
			task:start()
		end, {
			desc = "Run your makeprg as an Overseer task",
			nargs = "*",
			bang = true,
		}),
	},
}
