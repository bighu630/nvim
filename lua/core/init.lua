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
    vim.cmd([[
    set guifont=Consolas\ NF:h8.5
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
    vim.g.neovide_transparency = 0.8
end

local load_core = function()
    createdir()
    disable_distribution_plugins()
    leader_map()

    neovide_config()
    -- vim.cmd([[set background=light]])
    -- vim.cmd([[colorscheme zephyr]])
    vim.cmd([[colorscheme catppuccin-mocha]])
    -- vim.cmd[[colorscheme tokyonight-moon]]
end

local vim_config = function()
    vim.cmd([[
    let g:input_toggle = 1
    function! Fcitx2en()
        let s:input_status = system("fcitx5-remote")
        if s:input_status == 2
            let g:input_toggle = 1
            let l:a = system("fcitx5-remote -c")
        endif
    endfunction

    function! Fcitx2zh()
        if expand("%:e")== "md"
            let s:input_status = system("fcitx5-remote")
            if s:input_status != 2 && g:input_toggle == 1
                let l:a = system("fcitx5-remote -o")
                let g:input_toggle = 0
            endif
        endif
    endfunction

    "退出插入模式
    autocmd InsertLeave * call Fcitx2en()
    "进入插入模式

    autocmd FileType Outline setlocal signcolumn=no

    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd VimLeave !pkill gopls

    au BufNewFile,BufRead config set filetype=i3config
    au BufNewFile,BufRead .conkyrc set filetype=conkyrc

    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'lang.jdt'.lang_java()
    augroup end

    augroup _load_break_points
        autocmd!
        autocmd FileType c,cpp,go,python,lua,java :lua require('dap.dap-util').load_breakpoints()
    augroup end

    augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
    augroup END

    ]])
end

load_core()
vim_config()
