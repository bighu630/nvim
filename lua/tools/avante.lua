return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- add any opts here
		-- for example
		provider = "gemini",
		providers = {
			deepseek = {
				__inherited_from = "openai",
				api_key_name = "DEEPSEEK_API_KEY",
				endpoint = "https://api.deepseek.com",
				model = "deepseek-coder",
			},
			openrouter = {
				__inherited_from = "openai",
				disable_tools = true,
				api_key_name = "OPENROUTER_API_KEY",
				endpoint = "https://openrouter.ai/api/v1",
				model = "deepseek/deepseek-chat-v3-0324:free",
			},
			openai = {
				__inherited_from = "openai",
				api_key_name = "OPENAI_API_KEY",
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4", -- 或者 \"gpt-3.5-turbo\" 等
				extra_request_body = {
					temperature = 0.7,
				},
				max_tokens = 2048,
			},
			gemini = {
				model = "gemini-2.5-flash-preview-05-20",
				extra_request_body = {
					max_tokens = 8096,
					temperature = 0,
				},
			},
		},
		selector = {
			--- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
			provider = "snacks",
			-- Options override for custom providers
			provider_opts = {},
		},
		web_search_engine = {
			provider = "google", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
			proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
		},

		-- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		-- "echasnovski/mini.pick", -- for file_selector provider mini.pick
		-- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
		-- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		-- {
		-- 	-- support for image pasting
		-- 	"HakonHarnes/img-clip.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		-- recommended settings
		-- 		default = {
		-- 			embed_image_as_base64 = false,
		-- 			prompt_for_file_name = false,
		-- 			drag_and_drop = {
		-- 				insert_mode = true,
		-- 			},
		-- 			-- required for Windows users
		-- 			use_absolute_path = true,
		-- 		},
		-- 	},
		-- },
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
