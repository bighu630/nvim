local M = {}

function M.lualine()
	local colors = {
		bg = "none",
		normal = "#F8F8F8",
		grey = "#132434",
		grey1 = "#262626",
		grey2 = "#424242",
		grey3 = "#8B8B8B",
		grey4 = "#bdbdbd",
		grey5 = "#F8F8F8",
		violet = "#D484FF",
		blue = "#2f628e",
		cyan = "#00f1f5",
		green = "#A9FF68",
		green2 = "#2f7366",
		yellow = "#FFF59D",
		orange = "#F79000",
		red = "#F70067",
	}

	------------------------------------------------------------------
	-- mode (galaxyline ViMode)
	------------------------------------------------------------------
	local mode_color = {
		n = colors.green,
		i = colors.cyan,
		v = colors.violet,
		["\22"] = colors.cyan,
		V = colors.cyan,
		c = colors.red,
		no = colors.violet,
		s = colors.orange,
		S = colors.orange,
		["\19"] = colors.orange,
		ic = colors.yellow,
		cv = colors.red,
		ce = colors.red,
		["!"] = colors.green,
		t = colors.green,
		["r?"] = colors.red,
		["r"] = colors.red,
		rm = colors.red,
		R = colors.yellow,
		Rv = colors.violet,
	}

	local mode_alias = {
		n = " ",
		i = " ",
		c = " ",
		V = " ",
		["\22"] = " ",
		v = " ",
		["r?"] = ":CONFIRM",
		rm = "--MORE",
		R = " ",
		Rv = "VIRTUAL",
		s = " ",
		S = " ",
		["r"] = "HIT-ENTER",
		["\19"] = " ",
		t = " ",
		["!"] = "SHELL",
	}

	local function current_mode()
		return vim.api.nvim_get_mode().mode
	end

	local function mode_text()
		local m = current_mode()
		return (mode_alias[m] or "") .. " "
	end

	local function mode_highlight()
		return { fg = mode_color[current_mode()] or colors.normal, bg = colors.bg }
	end

	------------------------------------------------------------------
	-- helpers
	------------------------------------------------------------------
	local function buffer_not_empty()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end

	local function checkwidth()
		-- 按当前窗口宽度判断（分屏时 vim.o.columns 是整个屏幕宽度，会误判）
		return vim.api.nvim_win_get_width(0) / 2 > 60
	end

	local function stl_escape(str)
		return (str:gsub("%%", "%%%%"))
	end

	------------------------------------------------------------------
	-- file (icon / name / readonly)
	------------------------------------------------------------------
	local function file_icon()
		if not buffer_not_empty() then
			return ""
		end
		local ok, devicons = pcall(require, "nvim-web-devicons")
		if not ok then
			return ""
		end
		local icon = devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
		if icon and #icon > 0 then
			return icon .. " "
		end
		return ""
	end

	local function file_icon_highlight()
		if buffer_not_empty() then
			local ok, devicons = pcall(require, "nvim-web-devicons")
			if ok then
				-- NOTE: get_icon_color returns (icon, color) in nvim-web-devicons
				local _, color = devicons.get_icon_color(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
				if color then
					return { fg = color, bg = colors.bg }
				end
			end
		end
		return { fg = colors.normal, bg = colors.bg }
	end

	local function filename()
		if not buffer_not_empty() then
			return ""
		end
		return vim.fn.expand("%:t") .. " "
	end

	local function readonly()
		if vim.bo.filetype ~= "help" and vim.bo.readonly then
			return " "
		end
		return ""
	end

	------------------------------------------------------------------
	-- diagnostics (galaxyline Diagnostic*)
	------------------------------------------------------------------
	local severity = vim.diagnostic.severity

	local function diagnostic_count(diag_type)
		if vim.fn.exists("*coc#rpc#start_server") == 1 then
			local ok, info = pcall(vim.api.nvim_buf_get_var, 0, "coc_diagnostic_info")
			if not ok or not info then
				return 0
			end
			return info[diag_type] or 0
		end
		if vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 })) then
			return 0
		end
		local result = vim.diagnostic.get(0, { severity = severity[diag_type] })
		if result and #result ~= 0 then
			return #result
		end
		return 0
	end

	local function make_diagnostic(icon, diag_type)
		return function()
			local count = diagnostic_count(diag_type)
			if count and count > 0 then
				return icon .. count .. " "
			end
			return ""
		end
	end

	local diag_error = make_diagnostic(" ", "ERROR")
	local diag_warn = make_diagnostic(" ", "WARN")
	local diag_info = make_diagnostic(" ", "INFO")
	local diag_hint = make_diagnostic(" ", "HINT")

	------------------------------------------------------------------
	-- git (branch / diff)
	------------------------------------------------------------------
	local function git_branch()
		if not checkwidth() then
			return ""
		end
		local branch = vim.b.gitsigns_head
		if branch == nil or branch == "" then
			local dict = vim.b.gitsigns_status_dict
			branch = dict and dict.head
		end
		if branch == nil or branch == "" then
			return ""
		end
		return " " .. branch .. " "
	end

	local function diff_count(key)
		local dict = vim.b.gitsigns_status_dict
		if dict and dict[key] and dict[key] > 0 then
			return dict[key]
		end
		return nil
	end

	local function diff_add()
		if not checkwidth() then
			return ""
		end
		local count = diff_count("added")
		return count and " " .. count .. " " or ""
	end

	local function diff_modified()
		if not checkwidth() then
			return ""
		end
		local count = diff_count("changed")
		return count and " " .. count .. " " or ""
	end

	local function diff_remove()
		if not checkwidth() then
			return ""
		end
		local count = diff_count("removed")
		return count and " " .. count .. " " or ""
	end

	------------------------------------------------------------------
	-- right side (line:col / percent / filesize)
	------------------------------------------------------------------
	local function line_column()
		return string.format("%3d :%2d ", vim.fn.line("."), vim.fn.col("."))
	end

	local function line_percent()
		local current_line = vim.fn.line(".")
		local total_line = vim.fn.line("$")
		if current_line == 1 then
			return " Top "
		elseif current_line == total_line then
			return " Bot "
		end
		local result = math.floor((current_line / total_line) * 100)
		return " " .. result .. "% "
	end

	local function file_size()
		local file = vim.fn.expand("%:p")
		if string.len(file) == 0 then
			return ""
		end
		local size = vim.fn.getfsize(file)
		if size == 0 or size == -1 or size == -2 then
			return ""
		end
		if size < 1024 then
			size = size .. "b"
		elseif size < 1024 * 1024 then
			size = string.format("%.1f", size / 1024) .. "k"
		elseif size < 1024 * 1024 * 1024 then
			size = string.format("%.1f", size / 1024 / 1024) .. "m"
		else
			size = string.format("%.1f", size / 1024 / 1024 / 1024) .. "g"
		end
		return size .. " "
	end

	------------------------------------------------------------------
	-- middle fill line (galaxyline WinBar)
	------------------------------------------------------------------
	local left_providers = {
		mode_text,
		file_icon,
		filename,
		readonly,
		diag_error,
		diag_warn,
		diag_info,
		diag_hint,
		git_branch,
		diff_add,
		diff_modified,
		diff_remove,
	}
	local right_providers = { line_column, line_percent, file_size }

	local function text_width(providers)
		local used = 0
		for _, provider in ipairs(providers) do
			local text = provider()
			if text and #text > 0 then
				used = used + vim.fn.strdisplaywidth(text)
			end
		end
		return used
	end

	local function fill_line()
		local used = text_width(left_providers) + text_width(right_providers)
		-- one column is reserved for lualine's `%=` divider
		local available = vim.api.nvim_win_get_width(0) - used - 1
		if available < 2 then
			return ""
		end
		return "├" .. string.rep("─", available - 2) .. "┤"
	end

	local function fill_line_highlight()
		return { fg = vim.bo.modified and colors.cyan or colors.grey2, bg = colors.bg }
	end

	------------------------------------------------------------------
	-- short line (galaxyline short_line_left)
	------------------------------------------------------------------
	local function short_bar()
		local used = text_width({ file_icon, filename })
		local available = vim.api.nvim_win_get_width(0) - used - 1
		if available < 0 then
			available = 0
		end
		return string.rep("─", available)
	end

	local short_filetypes = {
		"dapui_scopes",
		"dapui_stacks",
		"dapui_watches",
		"dapui_breakpoints",
		"dapui_console",
		"LuaTree",
		"dbui",
		"term",
		"fugitive",
		"fugitiveblame",
		"NvimTree",
		"UltestSummary",
		"Avante",
		"AvanteSelectedFiles",
		"AvanteInput",
	}

	local function short_sections()
		return {
			lualine_a = {
				{ file_icon, color = file_icon_highlight, padding = 0 },
			},
			lualine_b = {
				{ filename, fmt = stl_escape, color = { fg = colors.normal, bg = colors.bg }, padding = 0 },
			},
			lualine_c = {
				{ short_bar, color = { fg = colors.grey2, bg = colors.bg }, padding = 0 },
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		}
	end

	------------------------------------------------------------------
	-- theme (transparent background like galaxyline)
	------------------------------------------------------------------
	local theme = {
		normal = {
			a = { fg = colors.normal, bg = colors.bg },
			b = { fg = colors.normal, bg = colors.bg },
			c = { fg = colors.normal, bg = colors.bg },
		},
		inactive = {
			a = { fg = colors.grey3, bg = colors.bg },
			b = { fg = colors.grey3, bg = colors.bg },
			c = { fg = colors.grey3, bg = colors.bg },
		},
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = theme,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "kd" }, winbar = {} },
			always_divide_middle = true,
			globalstatus = false,
		},
		sections = {
			lualine_a = {
				{ mode_text, color = mode_highlight, padding = 0 },
			},
			lualine_b = {
				{ file_icon, color = file_icon_highlight, padding = 0 },
				{
					filename,
					fmt = stl_escape,
					color = { fg = colors.normal, bg = colors.bg, gui = "bold" },
					padding = 0,
				},
				{ readonly, color = { fg = colors.cyan, bg = colors.bg }, padding = 0 },
				{ diag_error, color = { fg = colors.red, bg = colors.bg }, padding = 0 },
				{ diag_warn, color = { fg = colors.yellow, bg = colors.bg }, padding = 0 },
				{ diag_info, color = { fg = colors.green, bg = colors.bg }, padding = 0 },
				{ diag_hint, color = { fg = colors.cyan, bg = colors.bg }, padding = 0 },
			},
			lualine_c = {
				{
					git_branch,
					fmt = stl_escape,
					color = { fg = colors.grey3, bg = colors.bg, gui = "bold" },
					padding = 0,
				},
				{ diff_add, color = { fg = colors.green, bg = colors.bg, gui = "bold" }, padding = 0 },
				{ diff_modified, color = { fg = colors.yellow, bg = colors.bg, gui = "bold" }, padding = 0 },
				{ diff_remove, color = { fg = colors.red, bg = colors.bg, gui = "bold" }, padding = 0 },
				{ fill_line, color = fill_line_highlight, padding = 0 },
			},
			lualine_x = {
				{ line_column, color = { fg = colors.normal, bg = colors.bg }, padding = 0 },
			},
			lualine_y = {
				{
					line_percent,
					fmt = stl_escape,
					color = { fg = colors.cyan, bg = colors.bg, gui = "bold" },
					padding = 0,
				},
			},
			lualine_z = {
				{ file_size, color = { fg = colors.normal, bg = colors.bg }, padding = 0 },
			},
		},
		inactive_sections = short_sections(),
		tabline = {},
		extensions = {
			{
				filetypes = short_filetypes,
				sections = short_sections(),
			},
		},
	})
end

return M
