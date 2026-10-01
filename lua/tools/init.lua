return {
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",
		},
		cmd = "Leet",
		opts = require("tools.leetcode"),
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
            hererocks = true,
		},
		config = function(_, opts)
			-- 新版 LuaRocks 把 dkjson 装到了 luarocks/vendor/ 下（不再有顶层 dkjson.lua），
			-- 而 luarocks.core.persist 需要 require("dkjson")，
			-- 不补路径会报 "Unable to load the luarocks package loader"。
			local rocks = require("luarocks-nvim.paths").rocks
			package.path = package.path .. ";" .. rocks .. "/share/lua/5.1/luarocks/vendor/?.lua"
			require("luarocks-nvim").setup(opts)
		end,
	},
	{
		"3rd/image.nvim",
		dependencies = { "luarocks.nvim" },
		opts = {},
	},
	-- {
	-- 	"chipsenkbeil/distant.nvim",
	-- 	branch = "v0.3",
	-- 	config = function()
	-- 		require("distant").setup()
	-- 	end,
	-- },
	-- require("tools.avante"),
	-- require("tools.ai_agent").pi(),
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
	require("tools.translator"),
	-- {
	-- 	"voldikss/vim-translator",
	-- 	lazy = true,
	-- 	cmd = { "Translate", "TranslateW", "TranslateR", "TranslateV" },
	-- 	config = require("tools.translator").translator,
	-- },
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
	-- {
	-- 	url = "https://codeberg.org/andyg/leap.nvim",
	-- 	lzay = true,
	-- 	event = "BufReadPost",
	-- 	config = require("tools.leap").leap,
	-- },
	--
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
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
		"catgoose/nvim-colorizer.lua",
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
