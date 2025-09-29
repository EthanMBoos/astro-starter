return {
  "mfussenegger/nvim-dap",
  opts = function(_, opts)
    local dap = require("dap")

    dap.adapters.lldb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch LLDB",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }
  end,
}
