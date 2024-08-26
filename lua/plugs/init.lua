return {
	---------------------------------------主题/外观------------------------------------
	-- catppuccin , neo-tree ,accelerated-jk,noice
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		opts = require("ui.catppuccin"),
	},
	{
		"navarasu/onedark.nvim",
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
		"glepnir/galaxyline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = require("ui.galaxyline").galaxy,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = require("ui.dashboard").dashboard,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
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
	{
		"mhartington/formatter.nvim",
		config = require("lsp.formatter").formatter,
	},
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
			{ "f3fora/cmp-spell", after = "cmp-path" },
		},
		config = require("lsp.cmp").cmp,
	},
	-- {
	-- 	"ms-jpq/coq_nvim",
	-- 	branch = "coq",
	-- 	event = "InsertEnter",
	-- 	run = ":COQdeps",
	-- 	config = function()
	-- 		require("lsp.coq").coq()
	-- 	end,
	-- 	dependencies = {
	-- 		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
	-- 		{ "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
	-- 	},
	-- },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		lazy = true,
		after = "nvim-cmp",
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
	---------------------------------------lsp end--------------------------------------
	---------------------------------------lspsaga--------------------------------------
	-- lspsaga
	{
		"nvimdev/lspsaga.nvim",
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
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		ft = "java",
		config = require("lang.jdt").lang_java,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = require("lang.rust").lang_rust,
	},
	---------------------------------------lspsaga end----------------------------------
	-------------------------------------telescope -------------------------------------
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
	-------------------------------------telescope end----------------------------------

	-------------------------------------tools -----------------------------------------
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",
		},
		cmd = "Leet",
		opts = {
			{
				---@type string
				arg = "leetcode.nvim",

				---@type lc.lang
				lang = "golang",

				cn = { -- leetcode.cn
					enabled = true, ---@type boolean
					translator = true, ---@type boolean
					translate_problems = true, ---@type boolean
				},

				---@type lc.storage
				storage = {
					home = vim.fn.stdpath("data") .. "/leetcode",
					cache = vim.fn.stdpath("cache") .. "/leetcode",
				},

				---@type boolean
				logging = true,

				injector = {}, ---@type table<lc.lang, lc.inject>

				cache = {
					update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
				},

				console = {
					open_on_runcode = true, ---@type boolean

					dir = "row", ---@type lc.direction

					size = { ---@type lc.size
						width = "90%",
						height = "75%",
					},

					result = {
						size = "60%", ---@type lc.size
					},

					testcase = {
						virt_text = true, ---@type boolean

						size = "40%", ---@type lc.size
					},
				},

				description = {
					position = "left", ---@type lc.position

					width = "40%", ---@type lc.size

					show_stats = true, ---@type boolean
				},

				hooks = {
					---@type fun()[]
					LeetEnter = {},

					---@type fun(question: lc.ui.Question)[]
					LeetQuestionNew = {},
				},

				keys = {
					toggle = { "q", "<Esc>" }, ---@type string|string[]
					confirm = { "<CR>" }, ---@type string|string[]

					reset_testcases = "r", ---@type string
					use_testcase = "U", ---@type string
					focus_testcases = "H", ---@type string
					focus_result = "L", ---@type string
				},

				---@type boolean
				image_support = false,
			},
		},
	},
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
	},
	-- {
	-- 	"tonyfettes/fcitx5.nvim",
	-- 	config = function()
	-- 		-- Load `fcitx5.nvim`
	-- 		require("fcitx5").setup()
	-- 		-- Map <M-Tab> to toggle between most recent two input methods.
	-- 	end,
	-- 	rocks = { "lgi", "dbus_proxy" },
	-- },
	{
		"yaocccc/nvim-hlchunk",
		event = "BufReadPre",
	},
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
		lazy = false,
		config = require("tools.translator").translator,
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
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	},
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
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"michaelb/sniprun",
		run = "sh ./install.sh",
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
