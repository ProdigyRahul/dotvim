return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "mxsdev/nvim-dap-vscode-js",
      "microsoft/vscode-js-debug",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "delve",
        }
      })

      dapui.setup()

      -- JavaScript/TypeScript debugging setup
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require('dap.utils').pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome with \"localhost\"",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
          }
        }
      end

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keymaps
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<Leader>db", dap.step_back, { desc = "Step back" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<Leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
      vim.keymap.set("n", "<Leader>dd", dap.disconnect, { desc = "Disconnect" })
      vim.keymap.set("n", "<Leader>dg", dap.session, { desc = "Get session" })
      vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<Leader>dp", dap.pause, { desc = "Pause" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
      vim.keymap.set("n", "<Leader>ds", dap.continue, { desc = "Start" })
      vim.keymap.set("n", "<Leader>dq", dap.close, { desc = "Quit" })
      vim.keymap.set("n", "<Leader>dU", function() dapui.toggle({ reset = true }) end, { desc = "Toggle UI" })
    end,
  },
}