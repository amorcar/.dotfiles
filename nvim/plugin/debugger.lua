-- DAP debugger, dap-ui, mason-nvim-dap, dap-python (deferred: runs after VimEnter)
require("config.lazyload").on_vim_enter(function()
  local dap = require("dap")
  local dapui = require("dapui")

  -- telescope-dap
  require("telescope").load_extension("dap")

  -- nvim-dap-virtual-text
  require("nvim-dap-virtual-text").setup({
    enabled = true,
  })

  -- dap adapters
  local expand = vim.fn.expand
  dap.adapters.lldb = {
    type = "executable",
    command = expand("$HOME/.local/share/nvim/mason/bin/codelldb"),
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

  -- dap-ui
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "stacks",      size = 0.15 },
          { id = "scopes",      size = 0.50 },
          { id = "breakpoints", size = 0.25 },
          { id = "watches",     size = 0.10 },
        },
        position = "right",
        size = 80,
      },
      {
        elements = {
          { id = "repl",    size = 0.3 },
          { id = "console", size = 0.7 },
        },
        position = "bottom",
        size = 15,
      },
    },
  })

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- highlights and signs
  vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ad4e4e" })
  vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
  vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bold = true })

  vim.fn.sign_define("DapBreakpoint", { text = "", numhl = "DapBreakpoint" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", numhl = "DapBreakpoint", texthl = "DapBreakpoint" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", numhl = "DapBreakpoint", texthl = "DapBreakpoint" })
  vim.fn.sign_define("DapStopped", { text = "", numhl = "DapStopped", texthl = "DapStopped" })
  vim.fn.sign_define("DapLogPoint", { text = "", numhl = "DapLogPoint", texthl = "DapLogPoint" })

  -- debugger keymaps
  vim.keymap.set("n", "<leader>dtb", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
  vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Debug step into" })
  vim.keymap.set("n", "<F8>", dap.step_into, { desc = "Debug step into" })
  vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Debug step over" })
  vim.keymap.set("n", "<F9>", dap.step_over, { desc = "Debug step over" })
  vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "Debug step out" })
  vim.keymap.set("n", "<Leader>dtr", dap.repl.toggle, { desc = "Debug toggle REPL" })
  vim.keymap.set("n", "<leader>dtu", dapui.toggle, { desc = "Debug toggle UI" })
  vim.keymap.set("n", "<leader>dnj", "<cmd>lua require('dap').down()<cr>", { desc = "Debug navigate stack down" })
  vim.keymap.set("n", "<leader>dnk", "<cmd>lua require('dap').up()<cr>", { desc = "Debug navigate stack up" })

  -- mason-nvim-dap
  require("mason-nvim-dap").setup({
    handlers = {},
    ensure_installed = {
      "python",
      "codelldb",
    },
  })

  -- dap-python
  local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  require("dap-python").setup(path)
end)
