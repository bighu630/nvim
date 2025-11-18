return {
	"nvim-neotest/neotest",
	dependencies = {
		{ "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
		{ "leoluz/nvim-dap-go" },
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local neotest_golang_opts = {
			experimental = {
				test_table = true,
			},
			args = { "-v" },
			strategy = "dap",
		}
		require("neotest").setup({
			adapters = {
				-- require("neotest-golang")(neotest_golang_opts), -- Registration
				require("neotest-golang"),
			},
			strategies = {
				basic = {
					enabled = true, -- 使用 basic 策略
				},
			},
		})
	end,
}

