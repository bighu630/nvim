local config = {}

function config.comment()
    require("nvim_comment").setup({
        hook = function()
            require("ts_context_commentstring.internal").update_commentstring()
        end,
    })
end

return config
