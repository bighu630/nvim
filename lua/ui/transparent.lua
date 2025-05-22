local config = {}
function config.transparent()
	require("transparent").setup({
		groups = { -- table: default groups
			"Normal",
			"NormalNC",
			"NormalFloat",
			"Comment",
			"Constant",
			"Special",
			"Identifier",
			"Statement",
			"PreProc",
			"Type",
			"Underlined",
			"Todo",
			"String",
			"Function",
			"Conditional",
			"Repeat",
			"Operator",
			"Structure",
			"LineNr",
			"NonText",
			"SignColumn",
			"CursorLineNr",
			"EndOfBuffer",
			"barbar",
			"lualine",
			"lualine_c_command",
			"lualine_c_insert",
			"lualine_c_normal",
			"lualine_c_visual",
		},
		extra_groups = {
			"lualine",
			"barbar",
			"NvimTreeNormal",
		}, -- table: additional groups that should be cleared
		exclude_groups = {}, -- table: groups you don't want to clear
	})
end

return config
