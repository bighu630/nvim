return {
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
	require("tools.markdown"),
	{ "akinsho/git-conflict.nvim", event = "VeryLazy", version = "*", config = true },
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
	{
		"aserowy/tmux.nvim",
		lazy = false,
		config = require("tools.tmux").tmux,
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
	require("tools.neotest"),
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = require("tools.symbol-usage").symbol_usage,
	},
	{
		"lambdalisue/vim-suda",
	},
}
