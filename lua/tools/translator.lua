local config = {}

function config.translator()
    vim.cmd([[
    let g:translator_default_engines = ['google']
    ]])
end

return config
