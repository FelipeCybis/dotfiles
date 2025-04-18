return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python"
    },

    keys = {
      { "<leader>ds", function() require("dap").continue() end,          desc = "Continue/start debug" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dx", function() require("dap").terminate() end,         desc = "Terminate debug" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step into" },
    },
    config = function()
      -- Python dap setup
      require("dap-python").setup("uv")
      require("dap-python").test_runner = "pytest"
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'External code debugging',
        program = '${file}',
        justMyCode = false,
        -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
      })

      -- Signs
      for _, group in pairs({
        "DapBreakpoint",
        "DapBreakpointCondition",
        "DapBreakpointRejected",
        "DapLogPoint",
      }) do
        vim.fn.sign_define(group, { text = "●", texthl = group })
      end
      -- DAPUI
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
