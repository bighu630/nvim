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
			keight = { min = 10, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 20 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "center", -- align columns left, center or right
		},
		preset = "modern",
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
		-- { "<Space>s", group = "Session", nowait = true, remap = false },
		-- {
		-- 	"<Space>sl",
		-- 	"<cmd>SessionSearch<CR>",
		-- 	desc = "Load Session",
		-- 	nowait = true,
		-- 	remap = false,
		-- },
		-- {
		-- 	"<Space>sd",
		-- 	"<cmd>SessionDelete<CR>",
		-- 	desc = "Delete Session",
		-- 	nowait = true,
		-- 	remap = false,
		-- },
		-- {
		-- 	"<Space>ss",
		-- 	"<cmd>SessionSeva<CR>",
		-- 	desc = "Save Current Session",
		-- 	nowait = true,
		-- 	remap = false,
		-- },
		{ "<Space>s", group = "Session", nowait = true, remap = false }, -- 分组
		{
			"<Space>ss",
			function()
				require("persistence").load()
			end,
			desc = "Load current session",
			nowait = true,
			remap = false,
		},
		{
			"<Space>sS",
			function()
				require("persistence").select()
			end,
			desc = "Select session",
			nowait = true,
			remap = false,
		},
		{
			"<Space>sl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Load last session",
			nowait = true,
			remap = false,
		},
		{
			"<Space>sd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't save session",
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
		{ "<Space>a", group = "Avante", nowait = true, remap = false },
		{
			"<Space>aa",
			function()
				Snacks.dashboard.open()
			end,
			desc = "Welcome",
			nowait = true,
			remap = false,
		},
		{ "<Space>ac", "<cmd>AvanteChat<cr>", desc = "Show Sidebar / Start Chat", nowait = true, remap = false },
		{ "<Space>at", "<cmd>AvanteToggle<cr>", desc = "Toggle Sidebar", nowait = true, remap = false },
		{ "<Space>ar", "<cmd>AvanteRefresh<cr>", desc = "Refresh Sidebar", nowait = true, remap = false },
		{ "<Space>af", "<cmd>AvanteFocus<cr>", desc = "Switch Sidebar Focus", nowait = true, remap = false },
		{ "<Space>a?", "<cmd>AvanteModels<cr>", desc = "Select Model", nowait = true, remap = false },
		{ "<Space>ae", "<cmd>AvanteEdit<cr>", desc = "Edit Selected Blocks", nowait = true, remap = false },
		{ "<Space>aS", "<cmd>AvanteStop<cr>", desc = "Stop Current AI Request", nowait = true, remap = false },
		{ "<Space>ah", "<cmd>AvanteHistory<cr>", desc = "Select Chat History", nowait = true, remap = false },
		{ "<Space>an", "<cmd>AvanteChatNew<cr>", desc = "New Chat Session", nowait = true, remap = false },
		{ "<Space>aC", "<cmd>AvanteClear<cr>", desc = "Clear Current Chat", nowait = true, remap = false },
		{ "<Space>ap", "<cmd>AvanteSwitchProvider<cr>", desc = "Switch AI Provider", nowait = true, remap = false },
		{ "<Space>am", "<cmd>AvanteShowRepoMap<cr>", desc = "Show Repo Map", nowait = true, remap = false },
		{
			"<Space>as",
			"<cmd>AvanteSwitchSelectorProvider<cr>",
			desc = "Switch Selector Provider",
			nowait = true,
			remap = false,
		},
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
		-- { "<Space>f", "<cmd>Telescope frecency<cr>", desc = "Find Text", nowait = true, remap = false },
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
		{ "<Space>l", group = "LSP", nowait = true, remap = false },
		{
			"<Space>lR",
			function()
				local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
				for _, client in ipairs(clients) do
					if client.name then
						vim.cmd("LspRestart " .. client.name)
					end
				end
			end,
			desc = "Restart LSP",
			nowait = true,
			remap = false,
		},

		{ "<Space>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
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

		-- neotest
		{ "<space>t", group = "Neotest", nowait = true, remap = false },
		{ "<space>ts", "<cmd>lua require('neotest').summary.toggle()<cr>" },
		-- {
		-- 	"<Space>ls",
		-- 	"<cmd>Telescope lsp_document_symbols<cr>",
		-- 	desc = "Document Symbols",
		-- 	nowait = true,
		-- 	remap = false,
		-- },
		-- {
		-- 	"<Space>lw",
		-- 	"<cmd>Telescope lsp_workspace_diagnostics<cr>",
		-- 	desc = "Workspace Diagnostics",
		-- 	nowait = true,
		-- 	remap = false,
		-- },
		{ "<Space>o", "<cmd>Lspsaga outline<CR>", desc = "Outline", nowait = true, remap = false },
		-- { "<Space>p", "<cmd>Telescope project<cr>", desc = "Projects", nowait = true, remap = false },
		-- { "<Space>r", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
		-- {
		-- 	"ff",
		-- 	function()
		-- 		Snacks.explorer()
		-- 	end,
		-- 	desc = "File Explorer",
		-- },
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{ "<leader>f", group = "Picker" },
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<space>w",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<space>hk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- {
		-- 	"<leader>uC",
		-- 	function()
		-- 		Snacks.picker.colorschemes()
		-- 	end,
		-- 	desc = "Colorschemes",
		-- },
		-- LSP
		-- {
		-- 	"gd",
		-- 	function()
		-- 		Snacks.picker.lsp_definitions()
		-- 	end,
		-- 	desc = "Goto Definition",
		-- },
		-- {
		-- 	"gD",
		-- 	function()
		-- 		Snacks.picker.lsp_declarations()
		-- 	end,
		-- 	desc = "Goto Declaration",
		-- },
		-- {
		-- 	"gr",
		-- 	function()
		-- 		Snacks.picker.lsp_references()
		-- 	end,
		-- 	nowait = true,
		-- 	desc = "References",
		-- },
		-- {
		-- 	"gI",
		-- 	function()
		-- 		Snacks.picker.lsp_implementations()
		-- 	end,
		-- 	desc = "Goto Implementation",
		-- },
		-- {
		-- 	"gy",
		-- 	function()
		-- 		Snacks.picker.lsp_type_definitions()
		-- 	end,
		-- 	desc = "Goto Type Definition",
		-- },
		-- {
		-- 	"<leader>ss",
		-- 	function()
		-- 		Snacks.picker.lsp_symbols()
		-- 	end,
		-- 	desc = "LSP Symbols",
		-- },
		-- {
		-- 	"<leader>sS",
		-- 	function()
		-- 		Snacks.picker.lsp_workspace_symbols()
		-- 	end,
		-- 	desc = "LSP Workspace Symbols",
		-- },
		-- Other
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<c-\\>",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal()
			end,
			desc = "which_key_ignore",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	})

	which_key.setup(setup)
end

return config
