local function config()
	return {
		keymap = {
			-- set to 'none' to disable the 'default' preset
			preset = "default",

			["<tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = {
				"accept",
				"fallback",
			},
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			-- disable a keymap from the preset
			["<C-e>"] = {},

			-- show with a list of providers
			["<C-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				-- codeium = { name = "Codeium", module = "codeium.blink", async = true },
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 3,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = -3,
					opts = {
						friendly_snippets = true,
						-- search_paths = { vim.fn.stdpath("config") .. "/my-snippets" },
						global_snippets = { "all" },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					-- fallback = "lsp",
				},
			},
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = { border = "single" },
			},
			ghost_text = {
				enabled = false,
			},
			menu = {
				border = "rounded",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
				},
			},
		},
		signature = { window = { border = "single" } },
		enabled = function()
			return not vim.tbl_contains({ "NvimTree", "AvanteInput" }, vim.bo.filetype)
		end,
	}
end

return {
	"saghen/blink.cmp",
	dependencies = {
		-- add blink.compat to dependencies
		{ "saghen/blink.compat", opts = { impersonate_nvim_cmp = true } },
		{
			"Exafunction/codeium.nvim",
			cmd = "Codeium",
			event = "VeryLazy",
			build = ":Codeium Auth",
			opts = {
				virtual_text = {
					enabled = true,
					key_bindings = {
						-- Accept the current completion.
						accept = "<C-CR>",
						-- Accept the next word.
						accept_word = false,
						-- Accept the next line.
						accept_line = false,
						-- Clear the virtual text.
						clear = false,
						-- Cycle to the next completion.
						next = "<M-]>",
						-- Cycle to the previous completion.
						prev = "<M-[>",
					},
				},
			},
		},
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			dependencies = {
				"rafamadriz/friendly-snippets", -- 提供大量预设代码片段
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		-- ... Other dependencies
	},
	event = "BufReadPre",
	version = "*", -- REQUIRED release tag to download pre-built binaries
	-- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/blink-cmp.lua

	---@module "blink.cmp"
	---@type blink.cmp.Config
	---
	opts = config(),
}
