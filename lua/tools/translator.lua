local config = {}

function config.translator()
    vim.cmd([[
    let g:translator_default_engines = ['google']
    let g:translator_window_borderchars = ["─","│","─","│","╭","╮","╯","╰"]
    ]])
end

return config
