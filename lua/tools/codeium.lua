local config = {}

function config.codeium()
	if os.getenv("http_proxy") == "" then
		return {
			"Exafunction/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"hrsh7th/nvim-cmp",
			},
			config = function()
				require("codeium").setup({})
			end,
		}
	else
		return {}
	end
end

return config
