-- DAP adapter 定义：优先用 mason 安装的版本，找不到再回退到系统二进制。
-- 缺失的包（codelldb、js-debug-adapter 等）由 mason-nvim-dap 自动安装（见 lsp/mason.lua）。
local dap = require("dap")

local mason_dir = vim.fn.stdpath("data") .. "/mason"
local mason_bin = mason_dir .. "/bin"
local mason_pkg = mason_dir .. "/packages"

---在 mason 包目录里找第一个存在的文件
---@param ... string 候选路径（绝对路径）
---@return string|nil 命中的路径
local function first_exists(...)
	for _, p in ipairs({ ... }) do
		if p and vim.fn.filereadable(p) == 1 then
			return p
		end
	end
	return nil
end

---解析可执行文件：mason/bin 优先，其次 PATH
---@param name string
---@return string
local function exepath(name)
	if vim.fn.executable(mason_bin .. "/" .. name) == 1 then
		return mason_bin .. "/" .. name
	end
	return name -- 回退：走 PATH（mason setup PATH=prepend 后 mason/bin 本来就在 PATH 里）
end

-- Go：系统 dlv 与 mason delve 任一可用即可
dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = exepath("dlv"),
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

-- C/C++/Rust：mason codelldb（v2 布局 extension/adapter/codelldb，需 --port 参数）
local codelldb = first_exists(
	mason_pkg .. "/codelldb/extension/adapter/codelldb", -- mason v2 布局
	mason_pkg .. "/codelldb/codelldb" -- 旧布局兜底
) or exepath("codelldb")
local codelldb_adapter = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb,
		args = { "--port", "${port}" },
	},
}
dap.adapters.codelldb = codelldb_adapter
dap.adapters.lldb = codelldb_adapter -- 历史配置名（dap.configurations 里用的是 lldb），保留兼容

-- Python：系统 python3 + debugpy 优先（已验证可用），否则用 mason debugpy 虚拟环境
local mason_python = first_exists(
	mason_pkg .. "/debugpy/venv/bin/python",
	mason_pkg .. "/debugpy/bin/python"
)
local python_cmd = "python3"
if vim.fn.executable("python3") ~= 1 and mason_python then
	python_cmd = mason_python
end
dap.adapters.python = {
	type = "executable",
	command = python_cmd,
	args = { "-m", "debugpy.adapter" },
}

-- Bash：mason bash-debug-adapter（已安装），走 PATH 解析即可
dap.adapters.bashdb = {
	type = "executable",
	command = exepath("bash-debug-adapter"),
	name = "bashdb",
}

-- JS/TS：mason js-debug-adapter（之前 ~/usr/lib/js-debug 路径不存在，已改走 mason）
local js_debug = first_exists(
	mason_pkg .. "/js-debug-adapter/js-debug/src/dapDebugServer.js",
	mason_pkg .. "/js-debug-adapter/js-debug/js-debug/src/dapDebugServer.js"
) or (vim.env.HOME .. "/usr/lib/js-debug/dapDebugServer.js") -- 远古手动安装路径兜底
dap.adapters.pwa_node = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { js_debug, "${port}" },
	},
}
