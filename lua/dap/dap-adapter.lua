local dap = require("dap")

dap.adapters.go = {
	type = "server",
	port = "38698",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:38698" },
	},
}

dap.adapters.lldb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
	name = "lldb",
}

dap.adapters.python = {
	type = "executable",
	command = "/usr/bin/python",
	args = { "-m", "debugpy.adapter" },
}

dap.adapters.bashdb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
	name = "bashdb",
}
