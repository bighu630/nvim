local config = {}

function config.whichkey()
	local which_key = require("which-key")
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
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = {
			{ "<auto>", mode = "nixsotc" },
			{ "a", mode = { "n", "v" } },
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

	which_key.add({
		{ "<Space>s", group = "Session", nowait = true, remap = false },
		{
			"<Space>sl",
			"<cmd>SessionSearch<CR>",
			desc = "Load Session",
			nowait = true,
			remap = false,
		},
		{
			"<Space>sd",
			"<cmd>SessionDelete<CR>",
			desc = "Delete Session",
			nowait = true,
			remap = false,
		},
		{
			"<Space>ss",
			"<cmd>SessionSeva<CR>",
			desc = "Save Current Session",
			nowait = true,
			remap = false,
		},
		{ "<Space>R", group = "Replace", nowait = true, remap = false },
		{
			"<Space>Rf",
			"<cmd>lua require('spectre').open_file_search()<CR>",
			desc = "Replace File",
			nowait = true,
			remap = false,
		},
		{
			"<Space>Rp",
			"<cmd>lua require('spectre').open()<CR>",
			desc = "Replace Project",
			nowait = true,
			remap = false,
		},
		{
			"<Space>Rs",
			"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
			desc = "Search",
			nowait = true,
			remap = false,
		},
		{ "<Space>T", group = "Trouble", nowait = true, remap = false },
		{
			"<Space>Td",
			"<cmd>Trouble document_diagnostics<cr>",
			desc = "Document Diagnostics",
			nowait = true,
			remap = false,
		},
		{ "<Space>Tg", "<cmd>Gitsigns setloclist<cr>", desc = "Open changed hunk", nowait = true, remap = false },
		{ "<Space>Tq", "<cmd>Trouble quickfix<cr>", desc = "Quick Fix", nowait = true, remap = false },
		{ "<Space>Tt", "<cmd>Trouble<cr>", desc = "ToggleTrouble", nowait = true, remap = false },
		{ "<Space>Tu", "<cmd>Trouble lsp_references<cr>", desc = "Usage", nowait = true, remap = false },
		{
			"<Space>Tw",
			"<cmd>Trouble workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics",
			nowait = true,
			remap = false,
		},
		{ "<Space>a", "<cmd>Dashboard<cr>", desc = "Welcome", nowait = true, remap = false },
		-- { "<Space>c", group = "CMake", nowait = true, remap = false },
		-- { "<Space>cT", "<cmd>CMake select_build_type<CR>", desc = "SelectBuildType", nowait = true, remap = false },
		-- { "<Space>ca", "<cmd>CMake build_all<CR>", desc = "BuildAll", nowait = true, remap = false },
		-- { "<Space>cb", "<cmd>CMake build<CR>", desc = "BuildTarget", nowait = true, remap = false },
		-- { "<Space>cc", "<cmd>CMake cancel<CR>", desc = "Cancel", nowait = true, remap = false },
		-- { "<Space>cd", "<cmd>CMake build_and_debug<CR>", desc = "DebugTarget", nowait = true, remap = false },
		-- { "<Space>cg", "<cmd>CMake configure<CR>", desc = "Configure", nowait = true, remap = false },
		-- { "<Space>cr", "<cmd>CMake build_and_run<CR>", desc = "Run", nowait = true, remap = false },
		-- { "<Space>cs", "<cmd>CMake set_target_args<CR>", desc = "SetArg", nowait = true, remap = false },
		-- { "<Space>ct", "<cmd>CMake select_target<CR>", desc = "SelectTarget", nowait = true, remap = false },

		-- debug
		{ "<Space>d", group = "Debug", nowait = true, remap = false },
		{
			"<Space>dE",
			"<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
			desc = "Evaluate Input",
			nowait = true,
			remap = false,
		},
		{
			"<Space>dR",
			"<cmd>lua require'dap'.run_to_cursor()<cr>",
			desc = "Run to Cursor",
			nowait = true,
			remap = false,
		},
		{
			"<Space>dT",
			"<cmd>lua require'dapui'.toggle('sidebar')<cr>",
			desc = "Toggle Sidebar",
			nowait = true,
			remap = false,
		},
		{ "<Space>dX", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate", nowait = true, remap = false },
		{ "<Space>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", nowait = true, remap = false },
		{ "<Space>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = true, remap = false },
		{
			"<Space>dr",
			"<cmd>lua require'dap'.repl.toggle()<cr>",
			desc = "Toggle Repl",
			nowait = true,
			remap = false,
		},
		{ "<Space>f", "<cmd>Telescope frecency<cr>", desc = "Find Text", nowait = true, remap = false },
		{ "<Space>g", group = "Git", nowait = true, remap = false },
		{
			"<Space>gN",
			"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
			desc = "Prev Hunk",
			nowait = true,
			remap = false,
		},
		{
			"<Space>gR",
			"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
			desc = "Reset Buffer",
			nowait = true,
			remap = false,
		},
		{
			"<Space>gS",
			"<cmd>lua require 'gitsigns'.stage_buffer()<cr>",
			desc = "Stage Hunk",
			nowait = true,
			remap = false,
		},
		{
			"<Space>gU",
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			desc = "Undo Stage Hunk",
			nowait = true,
			remap = false,
		},
		{ "<Space>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
		{ "<Space>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
		{ "<Space>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
		{ "<Space>gf", "<cmd>DiffviewFileHistory<CR>", desc = "File History", nowait = true, remap = false },
		{
			"<Space>gl",
			"<cmd>lua require 'gitsigns'.blame_line()<cr>",
			desc = "Blame",
			nowait = true,
			remap = false,
		},
		{
			"<Space>gn",
			"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
			desc = "Next Hunk",
			nowait = true,
			remap = false,
		},
		{ "<Space>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
		{ "<Space>gp", "<cmd>DiffviewOpen<CR>", desc = "Diff Project", nowait = true, remap = false },
		{
			"<Space>gr",
			"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
			desc = "Reset Hunk",
			nowait = true,
			remap = false,
		},
		{
			"<Space>gs",
			"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
			desc = "Stage Hunk",
			nowait = true,
			remap = false,
		},
		{
			"<Space>gu",
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			desc = "Undo Stage Hunk",
			nowait = true,
			remap = false,
		},
		{ "<Space>h", group = "Help", nowait = true, remap = false },
		{ "<Space>hC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
		{ "<Space>hM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
		{ "<Space>hR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
		{ "<Space>hc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
		{ "<Space>hh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
		{ "<Space>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
		{ "<Space>l", group = "LSP", nowait = true, remap = false },
		{ "<Space>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
		{
			"<Space>lS",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			desc = "Workspace Symbols",
			nowait = true,
			remap = false,
		},
		{ "<Space>ld", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto_definition", nowait = true, remap = false },
		{ "<Space>lf", "<cmd>Format<cr>", desc = "Format", nowait = true, remap = false },
		{ "<Space>li", "<cmd>Lspsaga incoming_calls<cr>", desc = "Lspsaga incoming", nowait = true, remap = false },
		{
			"<Space>lj",
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			desc = "Next Diagnostic",
			nowait = true,
			remap = false,
		},
		{
			"<Space>lk",
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			desc = "Prev Diagnostic",
			nowait = true,
			remap = false,
		},
		{
			"<Space>ll",
			"<cmd>lua vim.lsp.buf.code_action()<cr>",
			desc = "Code Action",
			nowait = true,
			remap = false,
		},
		{ "<Space>lo", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Lspsaga Outgoing", nowait = true, remap = false },
		{
			"<Space>lq",
			"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
			desc = "Quickfix",
			nowait = true,
			remap = false,
		},
		{ "<Space>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
		{
			"<Space>ls",
			"<cmd>Telescope lsp_document_symbols<cr>",
			desc = "Document Symbols",
			nowait = true,
			remap = false,
		},
		{
			"<Space>lw",
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics",
			nowait = true,
			remap = false,
		},
		{ "<Space>o", "<cmd>Lspsaga outline<CR>", desc = "Outline", nowait = true, remap = false },
		{ "<Space>p", "<cmd>Telescope project<cr>", desc = "Projects", nowait = true, remap = false },
		{ "<Space>r", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	})

	which_key.setup(setup)
end

return config
