local config = {}

function config.spectre()
	require("spectre").setup({
		color_devicons = true,
		open_cmd = "vnew",
		live_update = false, -- auto excute search again when you write any file in vim
		line_sep_start = "┌-----------------------------------------",
		result_padding = "¦  ",
		line_sep = "└-----------------------------------------",
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
		mapping = {
			-- 删除选中
			["toggle_line"] = {
				map = "dd",
				cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
				desc = "toggle current item",
			},
			-- 前往文件
			["enter_file"] = {
				map = "o",
				cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
				desc = "goto current file",
			},
			-- 查看菜单（忽略大小写、忽略隐藏文件）
			["show_option_menu"] = {
				map = "<leader>o",
				cmd = "<cmd>lua require('spectre').show_options()<CR>",
				desc = "show option",
			},
			-- 开始替换
			["run_replace"] = {
				map = "<leader>r",
				cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
				desc = "replace all",
			},
			-- 显示差异
			["change_view_mode"] = {
				map = "<leader>v",
				cmd = "<cmd>lua require('spectre').change_view()<CR>",
				desc = "change result view mode",
			},
			-- you can put your mapping here it only use normal mode
		},
		find_engine = {
			-- rg is map with finder_cmd
			["rg"] = {
				cmd = "rg",
				-- default args
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
					-- you can put any rg search option you want here it can toggle with
					-- show_option function
				},
			},
			["ag"] = {
				cmd = "ag",
				args = {
					"--vimgrep",
					"-s",
				},
				options = {
					["ignore-case"] = {
						value = "-i",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
				},
			},
		},
		replace_engine = {
			["sed"] = {
				cmd = "sed",
				args = nil,
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},
			-- call rust code by nvim-oxi to replace
			["oxi"] = {
				cmd = "oxi",
				args = {},
				options = {
					["ignore-case"] = {
						value = "i",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},
		},
		default = {
			find = {
				--pick one of item in find_engine
				cmd = "rg",
				options = { "ignore-case" },
			},
			replace = {
				--pick one of item in replace_engine
				cmd = "sed",
			},
		},
		replace_vim_cmd = "cdo",
		is_open_target_win = true, --open file on opener window
		is_insert_mode = false, -- start open panel on is_insert_mode
	})
end

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
			borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			layout_strategy = "horizontal",
			-- layout_strategy = "cursor",
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
			-- frecency = {
			-- 	show_scores = true,
			-- 	show_unindexed = true,
			-- 	ignore_patterns = { "*.git/*", "*/tmp/*" },
			-- },
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				previewer = false,
				-- find_command = { "find", "-type", "f" },
				find_command = { "fd" },
			},

			-- Default configuration for builtin pickers goes here:
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
			buffers = {
				theme = "ivy",
			},
			git_files = {
				theme = "ivy",
			},
			grep_string = {
				theme = "ivy",
			},
			live_grep = {
				theme = "ivy",
			},
			oldfiles = {
				theme = "ivy",
			},
		},
	})
	-- vim.cmd([[packadd sqlite.lua]])
	vim.cmd([[packadd telescope-fzf-native.nvim]])
	vim.cmd([[packadd telescope-project.nvim]])
	-- vim.cmd([[packadd telescope-frecency.nvim]])
	vim.cmd([[packadd telescope-dap.nvim]])
	-- vim.cmd([[packadd telescope-zoxide]])

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
	-- require("telescope").load_extension("zoxide")
	-- require("telescope").load_extension("frecency")
	require("telescope").load_extension("dap")
end

function config.trouble()
	require("trouble").setup({
		position = "bottom", -- position of the list can be: bottom, top, left, right
		height = 10, -- height of the trouble list when position is top or bottom
		width = 50, -- width of the list when position is left or right
		icons = true, -- use devicons for filenames
		mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
		fold_open = "", -- icon used for open folds
		fold_closed = "", -- icon used for closed folds
		action_keys = {
			-- key mappings for actions in the trouble list
			-- map to {} to remove a mapping, for example:
			-- close = {},
			close = "q", -- close the list
			cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
			open_split = { "<c-x>" }, -- open buffer in new split
			open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
			open_tab = { "<c-t>" }, -- open buffer in new tab
			jump_close = { "o" }, -- jump to the diagnostic and close the list
			toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
			toggle_preview = "P", -- toggle auto_preview
			hover = "K", -- opens a small popup with the full multiline message
			preview = "p", -- preview the diagnostic location
			close_folds = { "zM", "zm" }, -- close all folds
			open_folds = { "zR", "zr" }, -- open all folds
			toggle_fold = { "zA", "za" }, -- toggle fold of current file
			previous = "k", -- preview item
			next = "j", -- next item
		},
		indent_lines = true, -- add an indent guide below the fold icons
		auto_open = false, -- automatically open the list when you have diagnostics
		auto_close = false, -- automatically close the list when you have no diagnostics
		auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
		auto_fold = false, -- automatically fold a file trouble list at creation
		signs = {
			-- icons / text used for a diagnostic
			error = "",
			warning = "",
			-- hint = "",
			information = "",
			other = "﫠",
		},
		use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
	})
end

function config.autosave()
	require("auto-save").setup({
		enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
		execution_message = {
			message = function() -- message to print on save
				return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
			end,
			dim = 0.18, -- dim the color of `message`
			cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
		},
		trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
		-- function that determines whether to save the current buffer or not
		-- return true: if buffer is ok to be saved
		-- return false: if it's not ok to be saved
		condition = function(buf)
			local fn = vim.fn
			local utils = require("auto-save.utils.data")

			if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
				return true -- met condition(s), can save
			end
			return false -- can't save
		end,
		write_all_buffers = false, -- write all buffers when the current one meets `condition`
		on_off_commands = true,
		-- clean_command_line_interval = 0,
		debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
		callbacks = { -- functions to be executed at different intervals
			enabling = nil, -- ran when enabling auto-save
			disabling = nil, -- ran when disabling auto-save
			before_asserting_save = nil, -- ran before checking `condition`
			before_saving = nil, -- ran before doing the actual save
			after_saving = nil, -- ran after doing the actual save
		},
		-- enabled = true,
		-- -- execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
		-- execution_message = "",
		-- events = { "InsertLeave", "TextChanged" },
		-- conditions = {
		-- 	exists = true,
		-- 	filename_is_not = { "plugins.lua" },
		-- 	filetype_is_not = {},
		-- 	modifiable = true,
		-- },
		-- write_all_buffers = false,
		-- on_off_commands = true,
		-- clean_command_line_interval = 0,
		-- debounce_delay = 135,
	})
end

function config.sniprun()
	require("sniprun").setup({
		selected_interpreters = {}, -- " use those instead of the default for the current filetype
		repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
		repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
		interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
		-- " you can combo different display modes as desired
		display = {
			"Classic", -- "display results in the command-line  area
			"VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
			"VirtualTextErr", -- "display error results as virtual text
			-- "TempFloatingWindow",      -- "display results in a floating window
			"LongTempFloatingWindow", -- "same as above, but only long results. To use with VirtualText__
			-- "Terminal"                 -- "display results in a vertical split
		},
		-- " miscellaneous compatibility/adjustement settings
		inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
		-- " to workaround sniprun not being able to display anything

		borders = "shadow", -- " display borders around floating windows
		-- " possible values are 'none', 'single', 'double', or 'shadow'
	})
end

function config.which_key()
	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local setup = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = false, -- bindings for folds, spelling and others prefixed with z
				g = false, -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		-- operators = { gc = "Comments" },
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
	}

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<Space>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		["a"] = { "<cmd>Alpha<cr>", "Welcome" },
		["r"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		-- ["b"] = {
		--   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		--   "Buffers",
		-- },
		-- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		-- ["w"] = { "<cmd>w!<CR>", "Save" },
		-- ["q"] = { "<cmd>q!<CR>", "Quit" },
		-- ["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
		["C"] = { "<cmd>%bd|e#<CR>", "Close Other Buffers" },
		-- ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		["f"] = {
			"<cmd>lua require('telescope.builtin').find_files()<cr>",
			-- "<cmd>lua require('telescope').extensions.frecenncy.frecency(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
			"Find files",
		},
		["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
		-- ["F"] = {
		-- 	"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy())<cr>",
		-- 	"Find Text",
		-- },
		["s"] = {
			"<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
			"Find Document Symbols",
		},
		["S"] = {
			"<cmd>SessionManager save_current_session<cr>",
			-- "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>",
			"Save session",
		},
		["p"] = { "<cmd>Telescope project<cr>", "Projects" },

		["P"] = { "<cmd>SessionManager load_session<cr>", "Projects" },

		-- ["t"] = {
		-- 	"<cmd>UltestSummary<CR>",
		-- 	"Unit Test",
		-- },

		["o"] = {
			"<cmd>AerialToggle<CR>",
			"Outline",
		},
		["v"] = {
			"<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_ivy())<cr>",
			"Clipboard Manager",
		},

		c = {
			name = "CMake",
			g = { "<cmd>CMake configure<CR>", "Configure" },
			t = { "<cmd>CMake select_target<CR>", "SelectTarget" },
			T = { "<cmd>CMake select_build_type<CR>", "SelectBuildType" },
			b = { "<cmd>CMake build<CR>", "BuildTarget" },
			a = { "<cmd>CMake build_all<CR>", "BuildAll" },
			r = { "<cmd>CMake build_and_run<CR>", "Run" },
			d = { "<cmd>CMake build_and_debug<CR>", "DebugTarget" },
			c = { "<cmd>CMake cancel<CR>", "Cancel" },
			s = { "<cmd>CMake set_target_args<CR>", "SetArg" },
		},

		d = {
			name = "Debug",
			R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
			E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
			X = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
			-- C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
			T = { "<cmd>lua require'dapui'.toggle('sidebar')<cr>", "Toggle Sidebar" },
			p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },

			-- b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			-- c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			-- d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			-- e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
			-- g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			-- h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
			-- S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
			-- i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			-- o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			-- t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			-- u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
		},

		T = {
			name = "Trouble",
			t = { "<cmd>Trouble<cr>", "ToggleTrouble" },
			d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
			w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
			q = { "<cmd>Trouble quickfix<cr>", "Quick Fix" },
			u = { "<cmd>Trouble lsp_references<cr>", "Usage" },
			g = { "<cmd>Gitsigns setloclist<cr>", "Open changed hunk" },
		},

		-- g = {
		--   name = "Git",
		--   b = { "<cmd>VGit buffer_gutter_blame_preview<cr>", "File Blame" },
		--   d = { "<cmd>VGit buffer_diff_preview<cr>", "Diff File" },
		--   D = { "<cmd>VGit project_diff_preview<cr>", "Diff Project" },
		--   s = { "<cmd>VGit buffer_stage<cr>", "Stage File" },
		--   u = { "<cmd>VGit buffer_unstage<cr>", "Unstage File" },
		--   r = { "<cmd>VGit buffer_reset<cr>", "Reset File" },
		--   f = { "<cmd>VGit buffer_history_preview <cr>", "Reset File" },
		--
		--   B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		--   c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		-- },

		g = {
			name = "Git",
			g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
			f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
			p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
			n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			N = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Hunk" },
			u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
			U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Diff",
			},
		},

		R = {
			name = "Replace",
			f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace File" },
			p = { "<cmd>lua require('spectre').open()<CR>", "Replace Project" },
			s = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search" },
			-- -- 全项目替换
			-- vim.keybinds.gmap("n", "<leader>rp", "", vim.keybinds.opts)
			-- -- 只替换当前文件
			-- vim.keybinds.gmap("n", "<leader>rf", , vim.keybinds.opts)
			-- -- 全项目中搜索当前单词
			-- vim.keybinds.gmap("n", "<leader>rw", , vim.keybinds.opts)
		},

		l = {
			name = "LSP",
			l = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			d = {
				"<cmd>Telescope lsp_document_diagnostics<cr>",
				"Document Diagnostics",
			},
			w = {
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				"Workspace Diagnostics",
			},
			f = { "<cmd>Format<cr>", "Format" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
			j = {
				"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
				"Prev Diagnostic",
			},
			q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
		},

		-- h = {
		--   a = { "<cmd>HSHighlight 1<cr>", "Hightlight 1" },
		--   b = { "<cmd>HSHighlight 2<cr>", "Hightlight 2" },
		--   c = { "<cmd>HSHighlight 3<cr>", "Hightlight 3" },
		--   d = { "<cmd>HSHighlight 4<cr>", "Hightlight 4" },
		--   e = { "<cmd>HSHighlight 5<cr>", "Hightlight 5" },
		--   f = { "<cmd>HSHighlight 6<cr>", "Hightlight 6" },
		--   u = { "<cmd>HSRmHighlight<cr>", "RemoveHighlight" },
		--   U = { "<cmd>HSRmHighlight rm_all<cr>", "RemoveAllHighlight" },
		-- },

		h = {
			name = "Help",
			-- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			-- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
		},

		-- t = {
		--   name = "Terminal",
		--   n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		--   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		--   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		--   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		--   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		--   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		--   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		-- },
	}

	which_key.setup(setup)
	which_key.register(mappings, opts)
end

-- function config.wilder()
-- 	vim.cmd([[
-- call wilder#setup({'modes': [':', '/', '?']})
-- call wilder#set_option('use_python_remote_plugin', 0)
-- call wilder#set_option('pipeline', [wilder#branch(
-- 	\ wilder#cmdline_pipeline({'use_python': 0,'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter()}),
-- 	\ wilder#vim_search_pipeline(),
-- 	\ [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})]
-- 	\ )])
-- call wilder#set_option('renderer', wilder#renderer_mux({
-- 	\ ':': wilder#popupmenu_renderer({
-- 		\ 'highlighter': wilder#lua_fzy_highlighter(),
-- 		\ 'left': [wilder#popupmenu_devicons()],
-- 		\ 'right': [' ', wilder#popupmenu_scrollbar()]
-- 		\ }),
-- 	\ '/': wilder#wildmenu_renderer({
-- 		\ 'highlighter': wilder#lua_fzy_highlighter(),
-- 		\ 'apply_incsearch_fix': v:true,
-- 		\})
-- 	\ }))
-- ]])
--     local wilder = require('wilder')
--     wilder.setup({modes = {':', '/', '?'}})
--     local gradient = {'#f89b31'
--     -- '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
--     -- '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
--     -- '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
--     -- '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
--     }
--
--     for i, fg in ipairs(gradient) do
--     gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', {{a = 1}, {a = 1}, {foreground = fg}})
--     end
--
--     wilder.set_option('renderer', wilder.popupmenu_renderer({
--     highlights = {
--         gradient = gradient, -- must be set
--         -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
--     },
--     highlighter = wilder.highlighter_with_gradient({
--         wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
--     }),
--     }))
-- end

function config.filetype()
	-- In init.lua or filetype.nvim's config file
	require("filetype").setup({
		overrides = {
			extensions = {
				-- Set the filetype of *.pn files to potion
				pn = "potion",
			},
			literal = {
				-- Set the filetype of files named "MyBackupFile" to lua
				MyBackupFile = "lua",
			},
			complex = {
				-- Set the filetype of any full filename matching the regex to gitconfig
				[".*git/config"] = "gitconfig", -- Included in the plugin
			},

			-- The same as the ones above except the keys map to functions
			function_extensions = {
				["cpp"] = function()
					vim.bo.filetype = "cpp"
					-- Remove annoying indent jumping
					vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
				end,
				["pdf"] = function()
					vim.bo.filetype = "pdf"
					-- Open in PDF viewer (Skim.app) automatically
					vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") .. '"')
				end,
			},
			function_literal = {
				Brewfile = function()
					vim.cmd("syntax off")
				end,
			},
			function_complex = {
				["*.math_notes/%w+"] = function()
					vim.cmd("iabbrev $ $$")
				end,
			},

			shebang = {
				-- Set the filetype of files with a dash shebang to sh
				dash = "sh",
			},
		},
	})
end

function config.project()
	require("project_nvim").setup({
		-- Manual mode doesn't automatically change your root directory, so you have
		-- the option to manually do so using `:ProjectRoot` command.
		manual_mode = false,

		-- Methods of detecting the root directory. **"lsp"** uses the native neovim
		-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
		-- order matters: if one is not detected, the other is used as fallback. You
		-- can also delete or rearangne the detection methods.
		detection_methods = { "lsp", "pattern" },

		-- All the patterns used to detect root dir, when **"pattern"** is in
		-- detection_methods
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

		-- Table of lsp clients to ignore by name
		-- eg: { "efm", ... }
		ignore_lsp = {},

		-- Don't calculate root dir on specific directories
		-- Ex: { "~/.cargo/*", ... }
		exclude_dirs = {},

		-- Show hidden files in telescope
		show_hidden = false,

		-- When set to false, you will get a message when project.nvim changes your
		-- directory.
		silent_chdir = true,

		-- What scope to change the directory, valid options are
		-- * global (default)
		-- * tab
		-- * win
		scope_chdir = "global",

		-- Path where project.nvim will store the project history for use in
		-- telescope
		datapath = vim.fn.stdpath("data"),
	})
end

function config.symbols_outline()
	local opts = {
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false,
		position = "right",
		relative_width = true,
		width = 25,
		auto_close = false,
		show_numbers = false,
		show_relative_numbers = false,
		show_symbol_details = true,
		preview_bg_highlight = "Pmenu",
		autofold_depth = nil,
		auto_unfold_hover = true,
		fold_markers = { "", "" },
		wrap = false,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			toggle_preview = "K",
			rename_symbol = "r",
			code_actions = "a",
			fold = "h",
			unfold = "l",
			fold_all = "W",
			unfold_all = "E",
			fold_reset = "R",
		},
		lsp_blacklist = {},
		symbol_blacklist = {},
		symbols = {
			File = { icon = "", hl = "TSURI" },
			Module = { icon = "", hl = "TSNamespace" },
			Namespace = { icon = "", hl = "TSNamespace" },
			Package = { icon = "", hl = "TSNamespace" },
			Class = { icon = "𝓒", hl = "TSType" },
			Method = { icon = "ƒ", hl = "TSMethod" },
			Property = { icon = "", hl = "TSMethod" },
			Field = { icon = "", hl = "TSField" },
			Constructor = { icon = "", hl = "TSConstructor" },
			Enum = { icon = "ℰ", hl = "TSType" },
			Interface = { icon = "ﰮ", hl = "TSType" },
			Function = { icon = "", hl = "TSFunction" },
			Variable = { icon = "", hl = "TSConstant" },
			Constant = { icon = "", hl = "TSConstant" },
			String = { icon = "𝓐", hl = "TSString" },
			Number = { icon = "#", hl = "TSNumber" },
			Boolean = { icon = "⊨", hl = "TSBoolean" },
			Array = { icon = "", hl = "TSConstant" },
			Object = { icon = "⦿", hl = "TSType" },
			Key = { icon = "🔐", hl = "TSType" },
			Null = { icon = "NULL", hl = "TSType" },
			EnumMember = { icon = "", hl = "TSField" },
			Struct = { icon = "𝓢", hl = "TSType" },
			Event = { icon = "🗲", hl = "TSType" },
			Operator = { icon = "+", hl = "TSOperator" },
			TypeParameter = { icon = "𝙏", hl = "TSParameter" },
		},
	}
	require("symbols-outline").setup()
end

function config.todo()
	require("todo-comments").setup({
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		-- keywords recognized as todo comments
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "#fbbf24", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "#10B981", alt = { "INFO" } },
			TEST = { icon = "⏲ ", color = "#ff00ff", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		gui_style = {
			fg = "NONE", -- The gui style to use for the fg highlight group.
			bg = "BOLD", -- The gui style to use for the bg highlight group.
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			before = "", -- "fg" or "bg" or empty
			keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = {}, -- list of file types to exclude highlighting
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of highlight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "Identifier", "#FF00FF" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	})
end

function config.session()
	require("session_manager").setup({
		-- sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
		path_replacer = "__", -- The character to which the path separator will be replaced for session files.
		colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
		autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
		autosave_last_session = false, -- Automatically save last session on exit and on session switch.
		autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
		autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
			"gitcommit",
			"kitty",
			"zshrc",
		},
		autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
		max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
	})
end

return config
