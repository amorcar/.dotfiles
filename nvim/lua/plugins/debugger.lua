return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"nvim-telescope/telescope-dap.nvim",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
				types = true,
			},
			"nvim-neotest/nvim-nio",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					enabled = true,
				},
			},
			{
				"LiadOz/nvim-dap-repl-highlights",
				config = function()
					require("nvim-dap-repl-highlights").setup()
				end,
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			local mason_registry = require("mason-registry")

			-- local codelldb = mason_registry.get_package("codelldb")
			-- local extension_path = codelldb:get_install_path() .. "/extension/"
			-- local codelldb_path = extension_path .. "adapter/codelldb"
			-- local liblldb_path = extension_path .. "Ildb/lib/liblldb.dylib"
			local expand = vim.fn.expand
			dap.adapters.lldb = {
				type = "executable",
				command = expand("$HOME/.local/share/nvim/mason/bin/codelldb"),
				-- command = "/usr/bin/lldb",
				name = "lldb",
			}

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			-- set up the UI
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "stacks",
								size = 0.15,
							},
							{
								id = "scopes",
								size = 0.50,
							},
							{
								id = "breakpoints",
								size = 0.25,
							},
							{
								id = "watches",
								size = 0.10,
							},
						},
						position = "right",
						size = 80,
					},
					{
						elements = {
							{
								id = "repl",
								size = 0.3,
							},
							{
								id = "console",
								size = 0.7,
							},
						},
						position = "bottom",
						size = 15,
					},
				},
			})

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

			vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ad4e4e" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
			vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bold = true })

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				numhl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "",
				numhl = "DapBreakpoint",
				texthl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "",
				numhl = "DapBreakpoint",
				texthl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapStopped", {
				text = "",
				numhl = "DapStopped",
				texthl = "DapStopped",
			})
			vim.fn.sign_define("DapLogPoint", {
				text = "",
				numhl = "DapLogPoint",
				texthl = "DapLogPoint",
			})

			-- debugger keymaps
			-- vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
			-- vim.keymap.set("n", "<leader>dr", dap.continue, {})
			-- vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, {vim.fn.input("Breakpoint condition: ")})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
			vim.keymap.set("n", "<leader>dsi", dap.step_into, {})
			vim.keymap.set("n", "<F8>", dap.step_into, {})
			vim.keymap.set("n", "<leader>dso", dap.step_over, {})
			vim.keymap.set("n", "<F9>", dap.step_over, {})
			vim.keymap.set("n", "<leader>dsu", dap.step_out, {})
			vim.keymap.set("n", "<Leader>dtr", dap.repl.toggle, {})
			vim.keymap.set("n", "<leader>dtu", dapui.toggle, {})
			vim.keymap.set("n", "<leader>dsj", "<cmd>lua require('dap').down()<cr>", {})
			vim.keymap.set("n", "<leader>dsk", "<cmd>lua require('dap').up()<cr>")
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		event = "VeryLazy",
		config = function()
			require("mason-nvim-dap").setup({
				handlers = {},
				ensure_installed = {
					-- should install debugpy
					"python",
					"codelldb",
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function(_, _)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
