return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      local mason_registry = require("mason-registry")

      -- local codelldb = mason_registry.get_package("codelldb")
      -- local extension_path = codelldb:get_install_path() .. "/extension/"
      -- local codelldb_path = extension_path .. "adapter/codelldb"
      -- local liblldb_path = extension_path .. "Ildb/lib/liblldb.dylib"

      dap.adapters.lldb = {
        type = "executable",
        command = "~/.local/share/nvim/mason/bin/codelldb",
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
            size = 30,
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
            size = 10,
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
      -- dap.listeners.before.event_terminated.dapui_config = function()
      -- 	dapui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      -- 	dapui.close()
      -- end

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
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    event="VeryLazy",
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
