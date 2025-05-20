local config = {}
function config.lspconfig()
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	vim.lsp.enable("gopls")
	vim.lsp.config("gopls", {
		flags = { debounce_text_changes = 500 },
		capabilities = capabilities,
		cmd = { "gopls", "-remote=auto" },
		settings = {
			gopls = {
				usePlaceholders = true,
				analyses = {
					nilness = true,
					shadow = true,
					unusedparams = true,
					unusewrites = true,
				},
			},
		},
	})
	vim.lsp.enable("pyright")
	vim.lsp.config("pyright", {})
	-- require("lsp.lsp")
end

return config
