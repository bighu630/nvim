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
    vim.g.load_perl_provider=0
    vim.g.load_ruby_provider=0
end

local leader_map = function()
	-- vim.g.mapleader = ","
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
	vim.cmd([[
    set guifont=JetBrainsMono\ Nerd\ Font:h7.5
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    ]])
	-- vim.cmd([[set guifont=Cascadia\ Code:h7]])
	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_cursor_trail_length = 0.05
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_speed = 20.0
	vim.g.neovide_cursor_vfx_particle_density = 5.0
	vim.g.neovide_transparency = 0.6
	vim.g.transparency = 0.6
	-- vim.g.neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
end

-- local check_conda = function()
-- 	local venv = os.getenv("CONDA_PREFIX")
-- 	if venv then
-- 		vim.g.python3_host_prog = venv .. "/bin/python"
-- 	end
-- end
--
-- local clipboard_config = function()
-- 	vim.cmd([[
--     let g:clipboard = {
--           \   'name': 'win32yank-wsl',
--           \   'copy': {
--           \      '+': 'win32yank.exe -i --crlf',
--           \      '*': 'win32yank.exe -i --crlf',
--           \    },
--           \   'paste': {
--           \      '+': 'win32yank.exe -o --lf',
--           \      '*': 'win32yank.exe -o --lf',
--           \   },
--           \   'cache_enabled': 0,
--           \ }
--     ]])
-- end

local load_core = function()
	local pack = require("core.pack")
	createdir()
	disable_distribution_plugins()
	leader_map()

	pack.ensure_plugins()
	neovide_config()
	-- check_conda()
	-- clipboard_config()

	require("core.options")
	require("core.mapping")
	require("keymap")
	require("core.event")
	pack.load_compile()

	-- vim.cmd([[set background=light]])
	vim.cmd([[colorscheme catppuccin]])
	-- vim.cmd([[colorscheme tokyonight-moon]])
end

local load_mysefconf = function()
	vim.cmd([[
    autocmd InsertLeave * :silent !fcitx5-remote -c 
    autocmd BufCreate *  :silent !fcitx5-remote -c
    autocmd BufEnter *  :silent !fcitx5-remote -c 
    autocmd BufLeave *  :silent !fcitx5-remote -c 

    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd VimLeave !pkill gopls

    au BufNewFile,BufRead config set filetype=i3config
    au BufNewFile,BufRead .conkyrc set filetype=conkyrc

    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'modules.lang.config'.lang_java()
    augroup end

    augroup _load_break_points
        autocmd!
        autocmd FileType c,cpp,go,python,lua,java :lua require('modules.editor.dap-util').load_breakpoints()
    augroup end

    ]])
	vim.g.loaded_netrw = true
	vim.g.loaded_netrwPlugin = true
end

load_core()
load_mysefconf()
