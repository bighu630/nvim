-- LSP 配置（Neovim 0.11+ 原生 vim.lsp.config / vim.lsp.enable API）
-- 安装与自动启用由 lsp/mason.lua（mason-lspconfig）负责，这里只做各 server 的个性化配置。
-- 顺序必须是：先全部 vim.lsp.config()，最后统一 vim.lsp.enable()。
local M = {}

-- 由本文件（而非 mason 自动启用）显式启用的 server 列表
M.servers = { "gopls", "pylsp", "clangd", "ts_ls", "lua_ls", "bashls", "html", "solidity_ls_nomicfoundation" }
-- 说明：rust_analyzer 由 rustaceanvim 接管；vtsls 与 ts_ls 重复，默认不用（见 lsp/mason.lua）。

function M.lspconfig()
	local ok, blink = pcall(require, "blink.cmp")
	local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

	-- 全局默认：所有 server 继承补全能力
	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	-- 所有个性化配置就绪后，再统一启用
	vim.lsp.enable(M.servers)

	-- 诊断显示
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded" },
	})
end

return M
