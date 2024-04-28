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
end

return config
