-- mason.nvim 全家桶：LSP / Formatter / Linter / DAP 的自动安装与自动启用
-- 插件 spec 见 plugs/init.lua，dependencies 会先于 lspconfig 加载，
-- 这里的 setup() 保证 mason 的 PATH / 安装器在 server 启动前就绪。
local M = {}

-- 由 mason-lspconfig 保证安装，并通过 automatic_enable 自动 vim.lsp.enable()。
-- 注意：这里只列“由 vim.lsp 统一管理”的 server。
M.servers = {
	"lua_ls",
	"gopls",
	"pylsp", -- 对应 mason 包 python-lsp-server
	"clangd",
	"bashls",
	"ts_ls", -- TypeScript/JavaScript（旧名 tsserver，已改名）
	"html",
	"solidity_ls_nomicfoundation", -- Solidity（对应 mason 包 nomicfoundation-solidity-language-server）
}

-- 由 mason-tool-installer 保证安装：formatter / linter 类工具
-- （formatter.nvim 里用到的 stylua / black / prettier，以及 shfmt）
M.tools = {
	"stylua",
	"prettier",
	"shfmt",
	"black",
}

-- 由 mason-nvim-dap 保证安装：各语言调试适配器
-- go(delve) / python(debugpy) 走系统二进制且工作正常，就不重复装了；
-- 这里补齐之前缺失/损坏的 codelldb、js-debug-adapter。
M.daps = {
	"codelldb",
	"js-debug-adapter",
	"bash-debug-adapter",
}

function M.setup()
	local ok, blink = pcall(require, "blink.cmp")
	local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
	require("mason").setup({
		PATH = "prepend", -- mason/bin 优先，保证 nvim  spawn 的永远是 mason 装的版本
		log_level = vim.log.levels.WARN,
		max_concurrent_installers = 4,
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	require("mason-lspconfig").setup({
		ensure_installed = M.servers,
		-- 已安装的 server 自动 vim.lsp.enable()；排除项由各自专用插件接管：
		-- rust_analyzer -> rustaceanvim，jdtls -> nvim-jdtls，
		-- vtsls -> 与 ts_ls 功能重复，默认只用 ts_ls，efm -> 无配置，空挂无意义。
		automatic_enable = {
			exclude = { "rust_analyzer", "jdtls", "vtsls", "efm" },
		},
		-- 这里可以不写 ensure_installed，完全靠你在 Mason 界面手动安装
		automatic_installation = true,

		-- 核心：配置默认的 handlers 自动启用所有已安装的 LSP
		handlers = {
			-- 第一个没有 key 的函数就是默认处理器
			function(server_name)
				require("nvim-lspconfig")[server_name].setup({
					capabilities = capabilities,
					-- 你可以在这里配置通用的 capabilities 或 on_attach
					-- capabilities = capabilities,
					-- on_attach = on_attach,
				})
			end,
		},
		-- 如果有个别 LSP 需要特殊配置，可以在下面单独写出来覆盖默认行为
		-- ["lua_ls"] = function()
		--     require("nvim-lspconfig").lua_ls.setup({ ... 特殊配置 ... })
		-- end,
	})

	require("mason-tool-installer").setup({
		ensure_installed = M.tools,
		auto_update = true,
		run_on_start = true,
	})

	-- 只做“安装器”：adapter 与 configurations 在 dap/dap-adapter.lua、
	-- dap/nvimdap.lua 里手动定义（指向 mason 路径），避免自动 setup 产生重复配置。
	require("mason-nvim-dap").setup({
		ensure_installed = M.daps,
		automatic_installation = true,
		automatic_setup = false,
	})
end

return M
