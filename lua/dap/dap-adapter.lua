local dap = require("dap")

dap.adapters.go = {
	type = "server",
	port = math.random(20000, 30000),
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
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

dap.adapters.pwa_node = {
	type = "server",
	host = "localhost",
	port = math.random(20000, 30000),
	executable = {
		command = "node",
		-- 💀 Make sure to update this path to point to your installation
		args = { vim.env.HOME .. "/.vscode/extensions/js-debug/src/dapDebugServer.js", port },
	},
}
