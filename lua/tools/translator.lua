-- local config = {}
--
-- function config.translator()
-- 	vim.cmd([[
--     let g:translator_default_engines = ['haici','google']
--     let g:translator_window_borderchars = ["─","│","─","│","╭","╮","╯","╰"]
--     " let g:translator_proxy_url = 'http://192.168.3.244:7890'
--     ]])
-- end
--
-- return config

return {
	"bighu630/kd_translate.nvim",
	config = function()
		require("kd").setup({
			window = {
				-- your window config here
			},
		})
	end,
	vim.keymap.set("n", "L", ":TranslateNormal<CR>"),
	vim.keymap.set("v", "L", ":TranslateVisual<CR>"),
}
