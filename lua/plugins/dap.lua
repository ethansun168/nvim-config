return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require "dap"
      vim.schedule(function()
        vim.fn.sign_define("DapBreakpoint", { text = "🔴" })
        vim.fn.sign_define("DapStopped", {
          text = "→",
          texthl = "DapStoppedGreen",
          linehl = "DapStoppedLine",
          numhl = "",
        })
        -- Bold green (like breakpoint's red)
        vim.cmd [[
            highlight DapStoppedGreen guifg=#00ff00 ctermfg=10 gui=bold cterm=bold
            highlight DapStoppedLine  guibg=#2a3a2a ctermbg=235
        ]]
      end)
      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          args = function()
            local input = vim.fn.input("Arguments (space-separated): ")
            return vim.split(input, " +")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          pid = function()
            local name = vim.fn.input "Executable name (filter): "
            return require("dap.utils").pick_process { filter = name }
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",
          target = "localhost:1234",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.cpp = dap.configurations.c
      local dapui = require "dapui"
      dapui.setup {
        controls = {
          icons = {
            disconnect = "",
            pause = "",
            play = " [dc]",
            run_last = "",
            step_back = "",
            step_into = " [di]",
            step_out = " [do]",
            step_over = " [dn]",
            terminate = " [dx]",
          },
        },
      }
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }
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
    end,
  },
}
