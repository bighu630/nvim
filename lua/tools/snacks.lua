local config = {
	"folke/snacks.nvim",
	priority = 1000,
	dependencies = {
		{
			"folke/persistence.nvim",
			opts = {
				need = 0,
				branch = true,
			},
		},
	},
	lazy = false,
	---@type snacks.Config
	opts = {
		animate = { enabled = true },
		bigfile = { enabled = true },
		---@class snacks.dashboard.Config
		dashboard = {
			enabled = true,
			autokeys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			formats = {
				key = function(item)
					return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
				end,
			},
			sections = {
				-- pane 2
				{ section = "header", height = 10 },
				{ title = "MRU", padding = 1 },
				{ section = "recent_files", limit = 8, padding = 1 },
				-- { title = "Session", padding = 1, pane = 2 },
				-- { section = "session", limit = 8, padding = 1, pane = 2 },
				{ title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
				{ section = "recent_files", cwd = true, limit = 8, padding = 1 },
				{
					section = "terminal",
					cmd = "fortune -s | cowsay",
					hl = "header",
					pane = 2,
				},
				{ title = "Bookmarks", padding = 1, pane = 2 },
				{ section = "keys", pane = 2 },
				{ title = "\nProjects", padding = 1, pane = 2 },
				{ section = "projects", padding = 1, pane = 2 },
			},
		},
		explorer = { enabled = false },
		indent = {
			priority = 1,
			enabled = false, -- enable indent guides
			char = "│",
			only_scope = false, -- only show indent guides of the scope
			only_current = false, -- only show indent guides in the current window
			hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
			-- can be a list of hl groups to cycle through
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
			margin = { top = 0, right = 1, bottom = 1 },
		},
		picker = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
		min = { enabled = true },
		git = { enabled = false },
		lazygit = { enabled = true },
		notify = { enabled = true },
		toggle = { enabled = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}

return config
