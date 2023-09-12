local config = {}
function config.dapui()
    require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        layouts = {
            {
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.25, -- Can be float or integer > 1
                    },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks",      size = 0.25 },
                    { id = "watches",     size = 0.25 },
                },
                size = 40,
                position = "left",
            },
            { elements = { "repl", "console" }, size = 10, position = "bottom" },
        },
        floating = {
            -- max_height = nil,
            -- max_width = nil,
            border = "rounded", -- Border style. Can be "single", "double" or "rounded"
            mappings = { close = { "q", "<Esc>" } },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil, -- Can be integer or nil.
        },
    })
end

function config.daptext()
    require("nvim-dap-virtual-text").setup({
        enabled = true,                  -- enable this plugin (the default)
        enabled_commands = true,         -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,         -- show stop reason when stopped for exceptions
        commented = false,               -- prefix virtual text with comment string
        only_first_definition = true,    -- only show virtual text at first definition (if there are multiple)
        all_references = false,          -- show virtual text on all all references of the variable (not only definitions)
        filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
        -- experimental features:
        virt_text_pos = "eol",           -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false,              -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,              -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil,         -- position the virtual text at a fixed window column (starting from the first text column) ,
    })
end

function config.nvimdap()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ABE9B3" })
    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#fB09B3" })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })

    dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
    }
    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "lldb",
            request = "launch",
            console = "integratedTerminal",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            args = function()
                local input = vim.fn.input("Input args: ")
                return require("dap.dap-util").str2argtable(input)
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},

            runInTerminal = false,
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
    require("dap.dap-go")

    dap.adapters.python = {
        type = "executable",
        command = "/usr/bin/python",
        args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
        {
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Launch file",
            console = "integratedTerminal",
            program = "${file}", -- This configuration will launch the current file if used.
            args = function()
                local input = vim.fn.input("Input args: ")
                return require("dap.dap-util").str2argtable(input)
            end,
            pythonPath = function()
                local venv_path = os.getenv("VIRTUAL_ENV")
                if venv_path then
                    return venv_path .. "/bin/python"
                end
                return "/usr/bin/python"
            end,
        },
    }

    dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
    }
    dap.configurations.sh = {
        {
            type = "bashdb",
            request = "launch",
            name = "Launch file",
            showDebugOutput = true,
            pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
            pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
            trace = true,
            file = "${file}",
            program = "${file}",
            cwd = "${workspaceFolder}",
            pathCat = "cat",
            pathBash = "/bin/bash",
            pathMkfifo = "mkfifo",
            pathPkill = "pkill",
            args = {},
            env = {},
            terminalKind = "integrated",
        },
    }
end

return config
