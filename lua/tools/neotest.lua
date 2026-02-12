return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			{
				"nvim-treesitter/nvim-treesitter", -- Optional, but recommended
				branch = "main", -- NOTE; not the master branch!
				build = function()
					vim.cmd(":TSUpdate go")
				end,
			},
			{
				"fredrikaverpil/neotest-golang",
				dependencies = {
					"leoluz/nvim-dap-go",
				},
				version = "*", -- Optional, but recommended; track releases
				build = function()
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
				end,
			},
		},
		config = function()
			local config = {
				runner = "gotestsum", -- Optional, but recommended
			}
			require("neotest").setup({
				discovery = {
					enabled = true,
					-- 只有当路径不包含系统敏感字符时才进行测试发现
					filter_dir = function(name, rel_path, root)
						-- 过滤掉常见的系统库和依赖路径
						return name ~= "vendor" and name ~= "node_modules" and not rel_path:match("go/pkg/mod") -- 过滤 Go 模块缓存
					end,
				},
				adapters = {
					require("neotest-golang")(config),
				},
			})
		end,
	},
}
