local M = {}

M.disabled = {
  n = {
    ['s'] = '',
    ['<C-n>'] = '',
    ['<C-j>'] = '',
    ['<C-k>'] = '',
    ['<C-h>'] = '',
    ['<C-l>'] = '',
    ['<C-s>'] = '',
    ['<C-c>'] = '',
    ['<Esc>'] = '',
    ['<Up>'] = '',
    ['<Down>'] = '',
    ['<leader>e'] = '',
    ['<leader>/'] = '',
    ['<leader>n'] = '',
    ['<leader>rn'] = '',
    ['<leader>ph'] = '',
    ['<leader>td'] = '',
    ['<leader>rh'] = '',
    ['<leader>gb'] = '',
    ['<leader>gt'] = '',
    ['<leader>fw'] = '',
    ['<leader>cm'] = '',
    ['<leader>q'] = '',
    ['<leader>lf'] = '',
    ['<leader>wr'] = '',
    ['<leader>wl'] = '',
    ['<leader>wa'] = '',
    ['<leader>ca'] = '',
    ['gr'] = '',
    ['gi'] = '',
    ['<A-h>'] = '',
    ['<leader>wk'] = '',
    ['<leader>wK'] = '',
    ['n'] = '',
    ['N'] = '',
  },

  v = {
    ['<leader>/'] = '',
    ['<Up>'] = '',
    ['<Down>'] = '',
  },

  i = {
    ['<C-h>'] = '',
    ['<C-l>'] = '',
  }
}

M.general = {
  n = {
    ['<leader>w'] = {
      '<cmd>:w<CR>',
      'Quick Save current buffer'
    },
    ['<C-h>'] = {
      '<cmd>nohlsearch<CR>',
      'Clear Highlights'
    },
    ['<leader>tn'] = {
      '<cmd> set nu! <CR>',
      'Toggle line number'
    },
    ["<leader>trn"] = {
      "<cmd> set rnu! <CR>",
      "Toggle relative number"
    },
    ["n"] = {
      "nzz",
      "Center next search result in screen"
    },
    ["N"] = {
      "Nzz",
      "Center previous search result in screen"
    },
  },

  i = {
    ['<C-a>'] = {
      '<ESC>^i',
      'Beginning of line',
    },
    ['<C-b>'] = {
      '<Left>',
      'Move left'
    },
    ['<C-f>'] = {
      '<Right>',
      'Move right'
    },
  },
}

M.gitsigns = {
  n = {
    -- git show diff
    ["<leader>gsd"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Git Preview Hunk",
    },
    -- git toggle deleted
    ["<leader>gtd"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Git Toggle Deleted",
    },
    -- git reset hunk
    ["<leader>grh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Git Reset Hunk",
    },
    ["<leader>gbl"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Git Blame Line",
    },
    ["<leader>gtb"] = {
      function()
        package.loaded.gitsigns.toggle_current_line_blame()
      end,
      "Git Toggle Blame line",
    },
  },
}

M.nvimtree = {
  n = {
    ['<C-b>'] = {
      '<cmd>NvimTreeToggle<CR>',
      'Toggle NvimTree'
    }
  }
}

M.telescope = {
  n = {
    ['<C-p>'] = {
      '<cmd>Telescope find_files<cr>',
      'Find files',
    },
    ['<leader>tgt'] = {
      '<cmd> Telescope git_status <CR>',
      'Telescope Git status'
    },
    ['<leader>fg'] = {
      '<cmd> Telescope live_grep <CR>',
      'Live grep'
    },
    ['<leader>tgc'] = {
      '<cmd> Telescope git_commits <CR>',
      'Git commits'
    },
    ['<leader>tle'] = {
      '<cmd> Telescope diagnostics <CR>',
      'Telescope List Workspace Errors'
    },
    ['<leader>q'] = {
      '<cmd> Telescope diagnostics bufnr=0 <CR>',
      'Telescope List Errors'
    },
    ['<leader>fws'] = {
      '<cmd> Telescope lsp_dynamic_workspace_symbols <CR>',
      'Find Workspace Symbols'
    },
    ['fr'] = {
      '<cmd> Telescope lsp_references <CR>',
      'Find References'
    },
    ['fi'] = {
      '<cmd> Telescope lsp_implementations <CR>',
      'Find Implementations'
    },
  },
}

M.lspconfig = {
  n = {
    ['<leader>ld'] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      'Floating Diagnostic'
    },
    ['<leader>lca'] = {
      function()
        vim.lsp.buf.code_action()
      end,
      'LSP Code Action'
    },
  }
}

M.nvterm = {
  n = {
    ['<A-t>'] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  },

  t = {
    ['<A-t>'] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  },
}

M.dap = {
  n = {
    ['<leader>db'] = {
      '<cmd> DapToggleBreakpoint <CR>',
      'Toggle Breakpoint'
    },
    ['<leader>dt'] = {
      function ()
        require("dapui").toggle()
      end,
      'Open debugging UI'
    },
    ['<leader>dr'] = {
      function ()
        require('dap').continue()
      end,
      'Start debugging session'
    },
    ['<leader>dor'] = {
      function ()
        require('dap').repl.open()
      end,
      'Open REPL'
    },
    ['<leader>dso'] = {
      function ()
        require('dap').step_over()
      end,
      'Step Over'
    },
    ['<leader>dsi'] = {
      function ()
        require('dap').step_into()
      end,
      'Step Over'
    },
  }
}

M.dap_python = {
  n = {
    ['<leader>dpr'] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

M.crates = {
  n = {
    ['<leader>rcu'] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      'Rust Crates Update'
    }
  }
}

return M
