local dap = require("dap")

dap.adapters.go = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		stdio = { nil, stdout },
		args = { "dap", "--check-go-version=false", "--listen=127.0.0.1:" .. port, "--log-dest=3" },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("dlv exited with code", code)
		end
	end)
	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	-- Wait for delve to start
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 1000)
end

dap.adapters.delve = {
	type = "server",
	port = "38698",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:38698" },
	},
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		console = "integratedTerminal",
		cwd = "${workspaceFolder}",
		program = "${file}",
		args = function()
			local input = vim.fn.input("Input args: ")
			return require("dap.dap-util").str2argtable(input)
		end,
	},
	{
		type = "delve",
		name = "Debug for Project",
		request = "launch",
		console = "integratedTerminal",
		cwd = "${workspaceFolder}",
		program = function()
			local path = vim.fn.expand("%:h")
			return "./" .. path
		end,
		args = function()
			local input = vim.fn.input("Input args: ")
			return require("dap.dap-util").str2argtable(input)
		end,
	},
	{
		type = "delve",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		console = "integratedTerminal",
		mode = "test",
		cwd = "${workspaceFolder}",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		console = "integratedTerminal",
		mode = "test",
		cwd = "${workspaceFolder}",
		program = "./${relativeFileDirname}",
	},
}
