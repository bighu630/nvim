local config = {}

function config.lang_go()
	require("go").setup()
	local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimport()
		end,
		group = format_sync_grp,
	})
end

function config.vim_go()
	vim.g.go_mod_fmt_autosave = 1
	vim.g.go_doc_keywordprg_enabled = 0
	vim.g.go_def_mapping_enabled = 0
	vim.g.go_addtags_transform = "camelcase"

	-- 保存时不再自动整理/补齐 import（保存卡顿的元凶：OrganizeImports 要加载整个包）
	-- 改为手动触发：go 文件里按 <leader>gi
	vim.g.go_imports_autosave = 0

	-- 保存格式化用 gofmt 二进制，不再让 vim-go 另起一个 gopls 去加载包
	vim.g.go_fmt_command = "gofmt"

	-- 如果连 gofmt 都不想自动跑，把下面这行打开，改成完全手动的 <leader>gf
	-- vim.g.go_fmt_autosave = 0
end

return config
