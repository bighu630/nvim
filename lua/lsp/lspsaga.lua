local config = {}
function config.lspsaga()
	require("lspsaga").setup({
		finder = {
			max_height = 0.5,
			min_width = 30,
			force_max_height = false,
			keys = {
				jump_to = "p",
				toggle_or_open = "<CR>",
				vsplit = "s",
				split = "i",
				tabe = "t",
				tabnew = "r",
				quit = { "q", "<ESC>" },
				close = "<ESC>",
			},
		},
		outline = {
			win_position = "right",
			win_with = "",
			win_width = 40,
			detail = true,
			auto_preview = true,
			auto_refresh = true,
			auto_close = true,
			custom_sort = nil,
			layout = "float",
			keys = {
				toggle_or_jump = "<CR>",
				quit = "q",
			},
		},
		custom_kind = {
			File = { " " },
			Module = { " " },
			Namespace = { " " },
			Package = { " " },
			Class = { "ﴯ " },
			Method = { " " },
			Property = { "ﰠ " },
			Field = { " " },
			Constructor = { " " },
			Enum = { " " },
			Interface = { " " },
			Function = { " " },
			Variable = { " " },
			Constant = { " " },
			String = { " " },
			Number = { " " },
			Boolean = { " " },
			Array = { " " },
			Object = { " " },
			Key = { " " },
			Null = { "ﳠ " },
			EnumMember = { " " },
			Struct = { " " },
			Event = { " " },
			Operator = { " " },
			TypeParameter = { " " },
			-- ccls-specific icons.
			TypeAlias = { " " },
			Parameter = { " " },
			StaticMethod = { "ﴂ " },
			Macro = { " " },
		},
		lightbulb = {
			enable = true,
			enable_in_insert = true,
			sign = true,
			sign_priority = 40,
			virtual_text = true,
		},
		ui = {
			-- Currently, only the round theme exists
			theme = "round",
			-- This option only works in Neovim 0.9
			title = true,
			-- Border type can be single, double, rounded, solid, shadow.
			border = "rounded",
			winblend = 0,
			expand = "▶ ",
			collapse = "▼ ",
			preview = " ",
			code_action = "💡",
			diagnostic = "🐞",
			incoming = " ",
			outgoing = " ",
			hover = " ",
			kind = {},
			lines = { "└", "├", "│", "─", "┌" },
			imp_sign = "󰳛 ",
		},
		symbol_in_winbar = {
			enable = true,
			separator = " › ",
			hide_keyword = false,
			ignore_patterns = nil,
			show_file = true,
			folder_level = 1,
			color_mode = true,
			dely = 300,
		},
		implement = {
			enable = true,
			sign = true,
			lang = {},
			virtual_text = true,
			priority = 100,
		},
	})
end

return config
