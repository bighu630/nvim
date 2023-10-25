local config = {}

function config.formatter()
	-- Utilities for creating configurations
	local util = require("formatter.util")
	local shiftwidth = vim.opt.shiftwidth:get()
	local expandtab = vim.opt.expandtab:get()

	-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
	require("formatter").setup({
		-- Enable or disable logging
		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		-- All formatter configurations are opt-in
		filetype = {
			-- Formatter configurations for filetype "lua" go here
			-- and will be executed in order
			lua = {
				-- "formatter.filetypes.lua" defines default configurations for the
				-- "lua" filetype
				require("formatter.filetypes.lua").stylua,

				-- You can also define your own configuration
				function()
					-- Supports conditional formatting
					if util.get_current_buffer_file_name() == "special.lua" then
						return nil
					end

					-- Full specification of configurations is down below and in Vim help
					-- files
					return {
						exe = "stylua",
						args = {
							"--search-parent-directories",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
							"--",
							"-",
						},
						stdin = true,
					}
				end,
			},

			-- Use the special "*" filetype for defining formatter configurations on
			-- any filetype
			python = {
				require("formatter.filetypes.python").black,

				-- You can also define your own configuration
				function()
					-- Supports conditional formatting
					if util.get_current_buffer_file_name() == "special.py" then
						return nil
					end

					-- Full specification of configurations is down below and in Vim help
					-- files
					return {
						exe = "black",
						args = {
							"-q",
							"-",
						},
						stdin = true,
					}
				end,
			},
			sh = {
				-- You can also define your own configuration
				function()
					-- Supports conditional formatting
					if util.get_current_buffer_file_name() == "special.sh" then
						return nil
					end

					-- Full specification of configurations is down below and in Vim help
					-- files
					return {
						exe = "shfmt",
						args = { "-i", shiftwidth },
						stdin = true,
					}
				end,
			},
			markdown = {
				function()
					if util.get_current_buffer_file_name() == "special.py" then
						return nil
					end
					return {
						exe = "prettier",
						args = {
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
							"--parser",
						},
						stdin = true,
					}
				end,
			},
			["*"] = {
				-- "formatter.filetypes.any" defines default configurations for any
				-- filetype
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		},
	})
end

return config
