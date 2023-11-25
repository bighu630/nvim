local dap = require("dap")

-- dap.adapters.go = function(callback, config)
-- 	local stdout = vim.loop.new_pipe(false)
-- 	local handle
-- 	local pid_or_err
-- 	local port = 38697
-- 	local opts = {
-- 		stdio = { nil, stdout },
-- 		args = { "dap", "--check-go-version=false", "--listen=127.0.0.1:" .. port, "--log-dest=3" },
-- 		detached = true,
-- 	}
-- 	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
-- 		stdout:close()
-- 		handle:close()
-- 		if code ~= 0 then
-- 			print("dlv exited with code", code)
-- 		end
-- 	end)
-- 	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
-- 	stdout:read_start(function(err, chunk)
-- 		assert(not err, err)
-- 		if chunk then
-- 			vim.schedule(function()
-- 				require("dap.repl").append(chunk)
-- 			end)
-- 		end
-- 	end)
-- 	-- Wait for delve to start
-- 	vim.defer_fn(function()
-- 		callback({ type = "server", host = "127.0.0.1", port = port })
-- 	end, 1000)
-- end

-- dap.adapters.go = function(callback, config)
-- 	-- Wait for delve to start
-- 	vim.defer_fn(function()
-- 		callback({ type = "server", host = "127.0.0.1", port = 38698 })
-- 	end, 100)
-- end
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
