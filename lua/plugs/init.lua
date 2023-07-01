return {
	---------------------------------------主题/外观-----------------------------
	-- catppuccin , neo-tree ,accelerated-jk,noice
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		opts = require("ui.catppuccin"),
	},
	-- {
	-- 	"kyazdani42/nvim-tree.lua",
	-- 	lazy = false,
	-- 	cmd = { "NvimTreeToggle" },
	-- 	config = require("ui.nvimtree").nvimtree,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the commands with "_with_window_picker" suffix
				"s1n7ax/nvim-window-picker",
				version = "v1.*",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },

								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
		config = require("ui.neotree").neotree,
	},
	-- accelerated-jk
	{
		"rainbowhxch/accelerated-jk.nvim",
		event = "BufWinEnter",
		config = require("ui.accelerated").accelerated,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = require("ui.notify").notify,
			},
		},
		config = require("ui.noice").noice,
	},
	{
		"hoob3rt/lualine.nvim",
		config = require("ui.lualine").lualine,
	},
	{
		"goolord/alpha-nvim",
		event = "BufWinEnter",
		config = require("ui.alpha").alpha,
	},
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
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "BufReadPost",
		config = require("ui.blankline").blankline,
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = require("ui.transparent"),
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufReadPost",
		config = require("ui.illuminate").illuminate,
	},
	---------------------------------------主题end-----------------------------

	---------------------------------------lsp-----------------------------
	-- nvim-lspconfig , efmls-configs , mason , cmp , lsp_signature
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "BufReadPre",
		config = require("lsp.lspconf").lspconfig,
	},
	{
		"creativenull/efmls-configs-nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = false,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				config = function()
					require("mason-tool-installer").setup({
						ensure_installed = {},
						auto_update = true,
						run_on_start = true,
					})
				end,
			},
		},
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	lazy = true,
	-- 	after = "nvim_lspconfig",
	-- },
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "BufReadPost",
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "lukas-reineke/cmp-under-comparator" },
			{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
			{ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
			{ "hrsh7th/cmp-cmdline", after = "cmp-nvim-lua" },
			{ "hrsh7th/cmp-path", after = "cmp-cmdline" },
			{ "hrsh7th/cmp-buffer", after = "cmp-path" },
		},
		config = require("lsp.cmp").cmp,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		after = "nvim-cmp",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = require("lsp.snip").luasnip,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "BufReadPost",
		config = require("lsp.autopairs").autopairs,
	},
	---------------------------------------lsp end-----------------------------
	---------------------------------------lspsaga-----------------------------
	-- lspsaga
	{
		"glepnir/lspsaga.nvim",
		envent = { "BufReadPost", "BufNewFile" },
		config = require("lsp.lspsaga").lspsaga,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
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
		"p00f/nvim-ts-rainbow",
		envent = "BufReadPost",
		after = "nvim-treesitter",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		envent = "BufReadPost",
		after = "nvim-treesitter",
	},
	{
		"mfussenegger/nvim-ts-hint-textobject",
		envent = "BufReadPost",
		after = "nvim-treesitter",
	},
	---------------------------------------lspsaga end-----------------------------
	---------------------------------------langguage -----------------------------
	-- vim-go
	{
		"fatih/vim-go",
		ft = "go",
		run = ":GoInstallBinaries",
		config = function()
			vim.g.go_doc_keywordprg_enabled = 0
			vim.g.go_def_mapping_enabled = 0
			vim.g.go_code_completion_enabled = 0
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		ft = "java",
		config = require("lang.jdt").lang_java,
	},
	---------------------------------------lspsaga end-----------------------------
	-------------------------------------telescope -------------------------------
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = "BufReadPost",
		module = "telescope",
		cmd = "Telescope",
		config = require("lsp.telescope").telescope,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", after = "telescope.nvim" },
			{ "nvim-telescope/telescope-project.nvim", after = "telescope.nvim" },
			{ "nvim-telescope/telescope-dap.nvim", after = "telescope.nvim" },
			{
				"nvim-telescope/telescope-frecency.nvim",
				after = "telescope.nvim",
				dependencies = {
					{ "kkharji/sqlite.lua", lazy = false },
				},
			},
		},
	},
	-------------------------------------telescope end-------------------------------
	--
	-------------------------------------tools --------------------------------------
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
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
		config = require("tools.trouble").trouble,
	},
	{
		"voldikss/vim-translator",
		lazy = false,
	},
	{
		"tpope/vim-surround",
		lazy = false,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		config = require("tools.todo").todo,
	},
	{
		"aserowy/tmux.nvim",
		lazy = false,
		config = require("tools.tmux").tmux,
	},
	{
		"terrortylor/nvim-comment",
		lazy = false,
		config = require("tools.comment").comment,
	},
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
	----------------------------------dap end----------------------------------------------
}
