return {
	---------------------------------------主题/外观------------------------------------
	-- catppuccin , neo-tree ,accelerated-jk,noice
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,
	-- 	name = "catppuccin",
	-- 	opts = require("ui.catppuccin"),
	-- },
	{
		-- "navarasu/onedark.nvim",
		"folke/tokyonight.nvim",
	},
	{
		"kyazdani42/nvim-tree.lua",
		lazy = false,
		cmd = { "NvimTreeToggle" },
		config = require("ui.nvimtree").nvimtree,
	},
	-- accelerated-jk
	{
		"rainbowhxch/accelerated-jk.nvim",
		event = "BufWinEnter",
		config = require("ui.accelerated").accelerated,
	},
	require("tools.snacks"),
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = require("ui.noice").noice,
	},
	{
		"glepnir/galaxyline.nvim",
		config = require("ui.galaxyline").galaxy,
	},
	require("ui.devicons"),
	-- {
	-- 	"glepnir/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	config = require("ui.dashboard").dashboard,
	-- 	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- },
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = require("ui.gitsigns").gitsigns,
	},
	{
		"romgrk/barbar.nvim",
		lazy = true,
		version = "*",
		event = "BufReadPost",
		config = require("ui.barbar").barbar,
	},
	{
		"mbbill/undotree",
		lazy = true,
		cmd = "UndotreeToggle",
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = require("ui.transparent").transparent,
	},
	-- require("tools.markdown"), // avante 中已经支持
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufReadPost",
		config = require("ui.illuminate").illuminate,
	},
	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = require("ui.scrollview").scrollview,
	},
	-- {
	-- 	"yaocccc/nvim-hlchunk",
	-- 	event = "BufReadPre",
	-- },
	---------------------------------------主题end--------------------------------------
	---------------------------------------lsp------------------------------------------
	-- nvim-lspconfig , efmls-configs , mason , cmp , lsp_signature
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "BufReadPre",
		config = require("lsp.lspconf").lspconfig,
	},
	-- {
	-- 	"mason-org/mason.nvim",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		{
	-- 			"mason-org/mason-lspconfig.nvim",
	-- 		},
	-- 		{
	-- 			"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 			config = function()
	-- 				require("mason-tool-installer").setup({
	-- 					ensure_installed = {},
	-- 					auto_update = true,
	-- 					run_on_start = true,
	-- 				})
	-- 			end,
	-- 		},
	-- 	},
	-- },
	{
		"mhartington/formatter.nvim",
		config = require("lsp.formatter").formatter,
	},
	require("lsp.blinkcmp"),
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = require("lsp.autopairs").autopairs,
	},
	---------------------------------------lsp end--------------------------------------
	---------------------------------------lspsaga--------------------------------------
	-- lspsaga
	{
		"nvimdev/lspsaga.nvim",
		envent = { "BufReadPost", "BufNewFile" },
		config = require("lsp.lspsaga").lspsaga,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				envent = "BufReadPost",
				config = require("lsp.treesitter").treesitter,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		envent = "BufReadPost",
		after = "nvim-treesitter",
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		envent = "BufReadPost",
		after = "nvim-treesitter",
		config = require("lsp.rainbow").rainbow,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		envent = "BufReadPost",
		after = "nvim-treesitter",
	},
	-- {
	-- 	"mfussenegger/nvim-ts-hint-textobject",
	-- 	envent = "BufReadPost",
	-- 	after = "nvim-treesitter",
	-- },
	---------------------------------------lspsaga end----------------------------------
	---------------------------------------langguage -----------------------------------
	{
		"fatih/vim-go",
		lazy = true,
		ft = "go",
		config = require("lang.go").vim_go,
	},
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	lazy = true,
	-- 	ft = "java",
	-- 	config = require("lang.jdt").lang_java,
	-- },
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	ft = "rust",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 	},
	-- 	config = require("lang.rust").lang_rust,
	-- },
	---------------------------------------lspsaga end----------------------------------

	-------------------------------------tools -----------------------------------------
	-- {
	-- 	"kawre/leetcode.nvim",
	-- 	build = ":TSUpdate html",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-lua/plenary.nvim", -- required by telescope
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	cmd = "Leet",
	-- 	opts = require("tools.leetcode"),
	-- },
	-- {
	-- 	"chipsenkbeil/distant.nvim",
	-- 	branch = "v0.3",
	-- 	config = function()
	-- 		require("distant").setup()
	-- 	end,
	-- },
	require("tools.avante"),
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		keys = "<Space>",
		config = require("tools.whichkey").whichkey,
	},
	{ "nvim-pack/nvim-spectre" },
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
		config = require("tools.trouble").trouble,
	},
	{
		"voldikss/vim-translator",
		lazy = true,
		cmd = { "Translate", "TranslateW", "TranslateR", "TranslateV" },
		config = require("tools.translator").translator,
	},
	-- {
	-- 	"tpope/vim-surround",
	-- 	lazy = false,
	-- },
	{
		"folke/todo-comments.nvim",
		lazy = false,
		event = "BufReadPost",
		config = require("tools.todo").todo,
	},
	-- {
	-- 	"aserowy/tmux.nvim",
	-- 	lazy = false,
	-- 	config = require("tools.tmux").tmux,
	-- },
	-- {
	-- 	"terrortylor/nvim-comment",
	-- 	lazy = false,
	-- 	config = require("tools.comment").comment,
	-- },
	{
		"ggandor/leap.nvim",
		lzay = true,
		event = "BufReadPost",
		config = require("tools.leap").leap,
	},
	{
		"romainl/vim-cool",
		lazy = true,
		event = { "CursorMoved", "InsertEnter" },
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = { "DiffviewOpen" },
	},
	{
		"mbbill/undotree",
		lazy = true,
		cmd = "UndotreeToggle",
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		event = "BufReadPost",
		config = require("tools.colorizer").colorizer,
	},
	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	config = function()
	-- 		require("project_nvim").setup({})
	-- 	end,
	-- },
	-- {
	-- 	-- amongst your other plugins
	-- 	"akinsho/toggleterm.nvim",
	-- 	version = "*",
	-- 	config = true,
	-- 	opts = {--[[ things you want to change go here]]
	-- 	},
	-- },
	require("tools.neotest"),
	-- {
	-- 	"github/copilot.vim",
	-- },
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({})
	-- 	end,
	-- },
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = require("tools.symbol-usage").symbol_usage,
	},
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	{
		"michaelb/sniprun",
		run = "sh ./install.sh",
		lazy = true,
		cmd = { "SnipRun", "SnipClose", "SnipInfo", "SnipReset" },
	},
	-- {
	-- 	"rmagatti/auto-session",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
	-- 	},
	--
	-- 	---enables autocomplete for opts
	-- 	---@module "auto-session"
	-- 	---@type AutoSession.Config
	-- 	opts = {
	-- 		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	-- 		-- log_level = 'debug',
	-- 	},
	-- },
	---------------------------------------------tools end -----------------------------
	----------------------------------dap ----------------------------------------------
	{
		"mfussenegger/nvim-dap",
		lzay = true,
		cmd = {
			"DapSetLogLevel",
			"DapShowLog",
			"DapContinue",
			"DapToggleBreakpoint",
			"DapToggleRepl",
			"DapStepOver",
			"DapStepInto",
			"DapStepOut",
			"DapTerminate",
		},
		module = "dap",
		dependencies = {
			{
				"nvim-neotest/nvim-nio",
			},
			{
				"rcarriga/nvim-dap-ui",
				lzay = true,
				config = require("dap.nvimdap").dapui,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				lazy = true,
				config = require("dap.nvimdap").daptext,
			},
		},
		config = require("dap.nvimdap").nvimdap,
	},
	----------------------------------dap end-------------------------------------------
}
