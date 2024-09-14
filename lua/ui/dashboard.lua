local config = {}

function config.dashboard()
	require("dashboard").setup({
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Files",
					group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = " OldFile",
					group = "DiagnosticHint",
					action = "Telescope oldfiles",
					key = "a",
				},
				{
					desc = " Session",
					group = "Session",
					action = "SessionSearch",
					key = "s",
				},
			},
		},
	})
end

return config
