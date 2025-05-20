local nvim_lsp = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
-- local coq = require("coq")

vim.lsp.util.make_text_document_params(0, "utf-8")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = coq.lsp_ensure_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities = require("blink.cmp").get_lsp_capabilities()

-- Override server settings here

local efmls_config = {
	settings = {
		rootMarkers = { ".git/" },
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}
