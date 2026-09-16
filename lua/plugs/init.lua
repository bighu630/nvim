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
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("ui.lualine").lualine,
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
	-- nvim-lspconfig , mason 全家桶 , cmp , lsp_signature
	-- mason 常驻（lazy=false）：负责 LSP/DAP/formatter 的自动安装与 PATH，
	-- 必须先于 lspconfig 就绪；具体列表见 lua/lsp/mason.lua
	{
		"mason-org/mason.nvim",
		lazy = false,
		priority = 100,
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
		dependencies = {
			{ "mason-org/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "jay-babu/mason-nvim-dap.nvim" },
		},
		config = function()
			require("lsp.mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "VeryLazy", "BufReadPre" },
		dependencies = {
			"saghen/blink.cmp",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
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
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	ft = "rust",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 	},
	-- 	config = require("lang.rust").lang_rust,
	-- },
	{
		"mrcjkb/rustaceanvim",
		-- To avoid being surprised by breaking changes,
		-- I recommend you set a version range
		version = "^9",
		-- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
		-- No need for lazy.nvim to lazy-load it.
		lazy = false,
	},
	---------------------------------------lspsaga end----------------------------------

	-------------------------------------tools -----------------------------------------
	require("tools"),
	---------------------------------------------tools end -----------------------------
	----------------------------------dap ----------------------------------------------
	require("dap.nvimdap"),
	----------------------------------dap end-------------------------------------------
}
