local config = {}
function config.telescope()
	require("telescope").setup({
		defaults = {
			buffer_previewer_maker = new_maker,
			initial_mode = "insert",
			prompt_prefix = "  ",
			selection_caret = "",
			entry_prefix = " ",
			scroll_strategy = "limit",
			results_title = false,
			-- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			-- layout_strategy = "horizontal",
			-- layout_strategy = "cursor",
			layout_strategy = "bottom_pane",
			-- layout_strategy = "vertical",
			path_display = { "absolute" },
			file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
			layout_config = {
				prompt_position = "bottom",
				horizontal = {
					preview_width = 0.5,
				},
			},
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			persisted = {
				layout_config = { width = 0.55, height = 0.55 },
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
		},
		pickers = {
			find_files = {
				theme = "cursor",
				previewer = false,
				-- find_command = { "find", "-type", "f" },
				find_command = { "fd" },
			},
		},
	})

	local telescope_actions = require("telescope.actions.set")
	local fixfolds = {
		hidden = true,
		attach_mappings = function(_)
			telescope_actions.select:enhance({
				post = function()
					vim.cmd(":normal! zx")
				end,
			})
			return true
		end,
	}

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("project")
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("dap")
end

return config
