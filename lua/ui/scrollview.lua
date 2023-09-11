local config = {}

function config.scrollview()
    local icons = { diagnostics = require("ui.icons").get("diagnostics", true) }

    require("scrollview").setup({
        excluded_filetypes = { "NvimTree", "terminal", "nofile", "Outline" },
        winblend = 0,
        signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },
        diagnostics_error_symbol = icons.diagnostics.Error,
        diagnostics_warn_symbol = icons.diagnostics.Warning,
        diagnostics_info_symbol = icons.diagnostics.Information,
        diagnostics_hint_symbol = icons.diagnostics.Hint,

    })
end

return config
