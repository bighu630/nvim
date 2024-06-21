local config = {}

function config.translator()
	vim.cmd([[
    let g:translator_default_engines = ['google']
    let g:translator_window_borderchars = ["─","│","─","│","╭","╮","╯","╰"]
    " let g:translator_proxy_url = 'http://192.168.3.244:7890'
    ]])
end

return config
