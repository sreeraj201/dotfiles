return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
        "igorlfs/nvim-dap-view",
    },
    config = function()
    local dap = require("dap")
    local dap_view = require("dap-view")

            -- LLDB DAP adapter installed through Homebrew
            dap.adapters.lldb = {
                type = "executable",
                command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
                name = "lldb",
            }

            -- C++ launch configuration
            dap.configurations.cpp = {
                {
                    name = "Launch C++",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input(
                            "Executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }

            dap.configurations.c = dap.configurations.cpp

            -- Debug UI
            dap_view.setup({
                windows = {
                    position = "right",
                },
            })

            -- Leader key mappings
            local map = vim.keymap.set
            local opts = { silent = true }

            map("n", "<leader>dc", dap.continue,
                vim.tbl_extend("force", opts, { desc = "Debug Continue" }))

            map("n", "<leader>db", dap.toggle_breakpoint,
                vim.tbl_extend("force", opts, { desc = "Toggle Breakpoint" }))

            map("n", "<leader>di", dap.step_into,
                vim.tbl_extend("force", opts, { desc = "Step Into" }))

            map("n", "<leader>do", dap.step_over,
                vim.tbl_extend("force", opts, { desc = "Step Over" }))

            map("n", "<leader>dO", dap.step_out,
                vim.tbl_extend("force", opts, { desc = "Step Out" }))

            map("n", "<leader>dt", dap.terminate,
                vim.tbl_extend("force", opts, { desc = "Terminate Debugger" }))

            map("n", "<leader>du", dap_view.toggle,
                vim.tbl_extend("force", opts, { desc = "Toggle Debug UI" }))

            map("n", "<leader>dr", dap.repl.toggle,
                vim.tbl_extend("force", opts, { desc = "Toggle Debug REPL" }))
        end,
    },

}

