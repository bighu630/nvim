require("core.lazy_nvim")
require("lazy").setup(require("plugs"))
require("core.options")
require("keymap")

local global = require("core.global")
local vim = vim

-- Create cache dir and subs dir
local createdir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
		global.cache_dir .. "undo",
	}
	-- There only check once that If cache_dir exists
	-- Then I don't want to check subs dir exists
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local disable_distribution_plugins = function()
	vim.g.did_load_filetypes = 1
	-- vim.g.did_load_fzf = 1
	vim.g.did_load_gtags = 1
	vim.g.did_load_gzip = 1
	vim.g.did_load_tar = 1
	vim.g.did_load_tarPlugin = 1
	vim.g.did_load_zip = 1
	vim.g.did_load_zipPlugin = 1
	vim.g.did_load_getscript = 1
	vim.g.did_load_getscriptPlugin = 1
	vim.g.did_load_vimball = 1
	vim.g.did_load_vimballPlugin = 1
	vim.g.did_load_matchit = 1
	vim.g.did_load_matchparen = 1
	vim.g.did_load_2html_plugin = 1
	vim.g.did_load_logiPat = 1
	vim.g.did_load_rrhelper = 1
	vim.g.load_perl_provider = 0
	vim.g.load_ruby_provider = 0
end

local leader_map = function()
	-- vim.g.mapleader = ","
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_cursor_trail_length = 0.05
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_speed = 21.0
	vim.g.neovide_cursor_vfx_particle_density = 5.0
	vim.g.neovide_transparency = 1
	if vim.fn.exists("g:neovide") == 1 then
		vim.cmd([[
            " set guifont=CodeNewRoman\ Nerd\ Font:h9.5
            set guifont=SFMono\ Nerd\ Font:h9.5
            let g:neovide_floating_blur_amount_x = 2.0
            let g:neovide_floating_blur_amount_y = 2.0
            set nocursorcolumn
            colorscheme catppuccin-mocha
        ]])
	end
end

local function session()
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		callback = function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				-- Don't save while there's any 'nofile' buffer open.
				if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
					return
				end
			end
			session_manager.save_current_session()
		end,
	})
end

local load_core = function()
	createdir()
	disable_distribution_plugins()
	leader_map()

	session()
	neovide_config()
end

local vim_config = function()
	vim.cmd("source ~/.config/nvim/lua/core/vimscript.vim")
end

load_core()
vim_config()
