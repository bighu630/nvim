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
	-- accelerated-jk
	{
		"rainbowhxch/accelerated-jk.nvim",
		event = "BufWinEnter",
		config = require("ui.accelerated").accelerated,
	},
	require("tools.snacks"),
	require("ui.noice"),
	{
		"bighu630/galaxyline.nvim",
		config = require("ui.galaxyline").galaxy,
	},
	require("ui.nvimtree"),
	require("ui.devicons"),
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
	---------------------------------------主题end--------------------------------------
	---------------------------------------lsp------------------------------------------
	-- nvim-lspconfig , efmls-configs , mason , cmp , lsp_signature
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "VeryLazy", "BufReadPre" },
		dependencies = {
			"saghen/blink.cmp",
		},
		config = require("lsp.lspconf").lspconfig,
	},
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
				branch = "main",
				envent = "BufReadPost",
				config = require("lsp.treesitter").treesitter,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		branch = "main",
		requires = "nvim-treesitter/nvim-treesitter",
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
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = require("lang.rust").lang_rust,
	},
	---------------------------------------lspsaga end----------------------------------

	-------------------------------------tools -----------------------------------------
	require("tools"),
	---------------------------------------------tools end -----------------------------
	----------------------------------dap ----------------------------------------------
	require("dap.nvimdap"),
	----------------------------------dap end-------------------------------------------
}
