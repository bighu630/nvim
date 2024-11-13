local config = {}
function config.markdown()
	require("markdown-preview").setup({
		autowrite = 1,
	})
end
