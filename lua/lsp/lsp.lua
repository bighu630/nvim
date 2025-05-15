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

mason_lsp.setup({
	ensure_installed = {
		-- "gopls", // 安装了vim-go
		"efm",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = coq.lsp_ensure_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = nvim_lsp.util.validate_bufnr(bufnr)
	local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	if clangd_client then
		clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
			if err then
				error(tostring(err))
			end
			if not result then
				vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
				return
			end
			vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
		end)
	else
		vim.notify(
			"Method textDocument/switchSourceHeader is not supported by any active server on this buffer",
			vim.log.levels.ERROR,
			{ title = "LSP Error!" }
		)
	end
end

-- Override server settings here

for _, server in ipairs(mason_lsp.get_installed_servers()) do
	-- if server == "gopls" then
	-- 	nvim_lsp.gopls.setup({
	-- 		flags = { debounce_text_changes = 500 },
	-- 		capabilities = capabilities,
	-- 		cmd = { "gopls", "-remote=auto" },
	-- 		settings = {
	-- 			gopls = {
	-- 				usePlaceholders = true,
	-- 				analyses = {
	-- 					nilness = true,
	-- 					shadow = true,
	-- 					unusedparams = true,
	-- 					unusewrites = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	if server == "sumneko_lua" then
		nvim_lsp.sumneko_lua.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim", "packer_plugins" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
					telemetry = { enable = false },
				},
			},
		})
	elseif server == "clangd" then
		local copy_capabilities = capabilities
		copy_capabilities.offsetEncoding = { "utf-16" }
		nvim_lsp.clangd.setup({
			capabilities = copy_capabilities,
			single_file_support = true,
			on_attach = custom_attach,
			cmd = {
				"clangd",
				"--background-index",
				"--pch-storage=memory",
				-- You MUST set this arg ↓ to your clangd executable location (if not included)!
				"--query-driver=/usr/bin/clang++,/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
				"--clang-tidy",
				"--all-scopes-completion",
				"--cross-file-rename",
				"--completion-style=detailed",
				"--header-insertion-decorators",
				"--header-insertion=iwyu",
			},
			commands = {
				ClangdSwitchSourceHeader = {
					function()
						switch_source_header_splitcmd(0, "edit")
					end,
					description = "Open source/header in current buffer",
				},
				ClangdSwitchSourceHeaderVSplit = {
					function()
						switch_source_header_splitcmd(0, "vsplit")
					end,
					description = "Open source/header in a new vsplit",
				},
				ClangdSwitchSourceHeaderSplit = {
					function()
						switch_source_header_splitcmd(0, "split")
					end,
					description = "Open source/header in a new split",
				},
			},
		})
	elseif server == "jsonls" then
		nvim_lsp.jsonls.setup({
			flags = { debounce_text_changes = 500 },
			capabilities = capabilities,
			settings = {
				json = {
					-- Schemas https://www.schemastore.org
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
						{
							fileMatch = { "tsconfig*.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
						{
							fileMatch = {
								".prettierrc",
								".prettierrc.json",
								"prettier.config.json",
							},
							url = "https://json.schemastore.org/prettierrc.json",
						},
						{
							fileMatch = { ".eslintrc", ".eslintrc.json" },
							url = "https://json.schemastore.org/eslintrc.json",
						},
						{
							fileMatch = {
								".babelrc",
								".babelrc.json",
								"babel.config.json",
							},
							url = "https://json.schemastore.org/babelrc.json",
						},
						{
							fileMatch = { "lerna.json" },
							url = "https://json.schemastore.org/lerna.json",
						},
						{
							fileMatch = {
								".stylelintrc",
								".stylelintrc.json",
								"stylelint.config.json",
							},
							url = "http://json.schemastore.org/stylelintrc.json",
						},
						{
							fileMatch = { "/.github/workflows/*" },
							url = "https://json.schemastore.org/github-workflow.json",
						},
					},
				},
			},
		})
	elseif server ~= "efm" then
		nvim_lsp[server].setup({
			capabilities = capabilities,
		})
	end
end

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin

nvim_lsp.html.setup({
	cmd = { "html-languageserver", "--stdio" },
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
	settings = {},
	single_file_support = true,
	flags = { debounce_text_changes = 500 },
	capabilities = capabilities,
})

local efmls_config = {
	settings = {
		rootMarkers = { ".git/" },
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}
require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
	capabilities = capabilities,
	init_options = { documentFormatting = true, codeAction = true },

	-- Pass your cutom config below like on_attach and capabilities
	--
	-- on_attach = on_attach,
	-- capabilities = capabilities,
}))
