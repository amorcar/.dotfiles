return {
	{
		"muffsenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- set up the UI
			dapui.setup()

			-- open and close the UI automatically
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
      -- keep debugger UI open after session is over?
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dr", dap.continue, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
			vim.keymap.set("n", "<leader>dtu", dapui.toggle, {})
			vim.keymap.set("n", "<leader>dsi", dap.step_into, {})
			vim.keymap.set("n", "<leader>dso", dap.step_over, {})
			vim.keymap.set("n", "<leader>dsu", dap.step_out, {})
		end,
	},
	{
		"muffsenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"muffsenegger/nvim-dap",
		},
		config = function(_, _)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
