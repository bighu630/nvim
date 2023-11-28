local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
require("keymap.config")
vim.g.mapleader = ";"

local buffer_map = {
	-- Bufferline
	["n|R"] = map_cr("BufferNext"):with_noremap():with_silent(),
	["n|E"] = map_cr("BufferPrevious"):with_noremap():with_silent(),
	["n|B"] = map_cr("BufferPick"):with_noremap():with_silent(),
	["n|x"] = map_cr("BufferClose"):with_noremap():with_silent(),
}

local lspsaga_map = {
	["n|<F2>"] = map_cr("Lspsaga outline"):with_noremap():with_silent(),
	["n|="] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent(),
	["n|-"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent(),
	["n|gs"] = map_cr("Lspsaga signature_help"):with_noremap():with_silent(),
	["n|gr"] = map_cr("Lspsaga rename"):with_noremap():with_silent(),
	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
	-- ["n|J"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
	["n|<Space>ll"] = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
	["v|<leader>ca"] = map_cu("Lspsaga code_action"):with_noremap():with_silent(),
	["n|gp"] = map_cr("Lspsaga peek_definition"):with_noremap():with_silent(),
	["n|gd"] = map_cr("Lspsaga goto_definition"):with_noremap():with_silent(),
	["n|gD"] = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(),
	["n|gh"] = map_cr("Lspsaga finder"):with_noremap():with_silent(),
}

local git_map = {
	["n|gps"] = map_cr("G push"):with_noremap():with_silent(),
	["n|gpl"] = map_cr("G pull"):with_noremap():with_silent(),
	-- toggleterm
	["n|<C-\\>"] = map_cr("Lspsaga term_toggle"):with_noremap():with_silent(),
	["n|<leader>G"] = map_cu("Git"):with_noremap():with_silent(),
}

local trouble_map = {
	-- Plugin trouble
	["n|gt"] = map_cr("TroubleToggle"):with_noremap():with_silent(),
	["n|<Space>u"] = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent(),
	["n|<leader>cd"] = map_cr("TroubleToggle document_diagnostics"):with_noremap():with_silent(),
	["n|<leader>cw"] = map_cr("TroubleToggle workspace_diagnostics"):with_noremap():with_silent(),
	["n|<leader>cq"] = map_cr("TroubleToggle quickfix"):with_noremap():with_silent(),
	["n|<leader>cl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent(),
}

local tree_map = {
	-- 打开文件树
	["n|ff"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
	-- Plugin Undotree
	["n|<Leader>u"] = map_cr("UndotreeToggle"):with_noremap():with_silent(),
}

local telescope_map = {
	["n|<Space>p"] = map_cu("lua require('telescope').extensions.project.project{}"):with_noremap():with_silent(),
	["n|<Space>r"] = map_cu("Telescope oldfiles"):with_noremap():with_silent(),
	["n|<Space>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
	["n|<Leader>sc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent(),
	["n|<Leader>fn"] = map_cu(":enew"):with_noremap():with_silent(),
	["n|<Space>w"] = map_cu("Telescope live_grep"):with_noremap():with_silent(),
	["n|<Leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent(),
	["n|<Leader>fz"] = map_cu("Telescope zoxide list"):with_noremap():with_silent(),
	["n|<Space>hk"] = map_cu("Telescope keymaps"):with_noremap():with_silent(),
}

local dap_map = {
	-- Plugin dap
	["n|<F5>"] = map_cr('lua require("dap.ext.vscode").load_launchjs();require("dap").continue()')
		:with_noremap()
		:with_silent(),
	["n|<F4>"] = map_cr("lua require('dap').terminate() require('dapui').close()"):with_noremap():with_silent(),
	["n|<F2>"] = map_cr("lua require('dap').toggle_breakpoint();require('dap.dap-util').store_breakpoints(true)")
		:with_noremap()
		:with_silent(),
	["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint();require('dap.dap-util').store_breakpoints(true)")
		:with_noremap()
		:with_silent(),
	["n|<leader>dB"] = map_cr("lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))")
		:with_noremap()
		:with_silent(),
	["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap():with_silent(),
	["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_noremap():with_silent(),
	["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_noremap():with_silent(),
	["n|<F6>"] = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
	["n|<F7>"] = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
	["n|<F8>"] = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
	["n|<leader>dl"] = map_cr("lua require('dap').repl.open()"):with_noremap():with_silent(),
	["n|J"] = map_cr("lua require('dapui').eval()"):with_silent(),
}

local plug_map = {
	-- Lsp mapp work when insertenter and lsp start
	["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
	["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
	-- Plugin nvim-tree
	-- ["n|ff"] = map_cr("NeoTreeFocusToggle"):with_noremap():with_silent(),
	-- ["n|fd"] = map_cr("NeoTreeFloatToggle"):with_noremap():with_silent(),
	-- Plugin Telescope
	-- Plugin accelerate-jk,加速jk的移动速度
	["n|j"] = map_cmd("v:lua.enhance_jk_move('j')"):with_silent():with_expr(),
	["n|k"] = map_cmd("v:lua.enhance_jk_move('k')"):with_silent():with_expr(),
	-- Plugin vim-eft
	-- ["n|f"] = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
	-- ["n|F"] = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
	-- ["n|t"] = map_cmd("v:lua.enhance_ft_move('t')"):with_expr(),
	-- Plugin leap
	["n|s"] = map_cmd([[<Plug>(leap-forward-x)]]):with_silent(),
	["n|<S-s>"] = map_cmd([[<Plug>(leap-backward-x)]]):with_silent(),
	-- Plugin EasyAlign
	["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
	["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),
	-- Plugin MarkdownPreview
	["n|<F12>"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent(),
	-- Plugin auto_session
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent(),
	-- ["n|<leader>sr"] = map_cu("RestoreSession"):with_noremap():with_silent(),
	-- ["n|<leader>sd"] = map_cu("DeleteSession"):with_noremap():with_silent(),
	-- Plugin SnipRun
	["v|<leader>rf"] = map_cr("SnipRun"):with_noremap():with_silent(),
	["n|<leader>rf"] = map_cr("%SnipRun"):with_noremap():with_silent(),
	-- SnipRun
	["o|m"] = map_cu([[lua require('tsht').nodes()]]):with_silent(),
	["c|Q"] = map_cu([[%SnipRun]]):with_silent(),
	-- Plugin Tabout
	["i|<C-j>"] = map_cmd([[<Plug>(TaboutMulti)]]):with_silent(),
	["i|<C-k>"] = map_cmd([[<Plug>(TaboutBackMulti)]]):with_silent(),
	-- My keymap
	["n|<S-q>"] = map_cr("q"):with_silent():with_noremap(),
	["n|<->"] = map_cr("lua vim.diagnostic.goto_next({})"),
	["n|<=>"] = map_cr("lua vim.diagnostic.goto_prev({})"),
	-- Translateor
	["n|<S-l>"] = map_cr("TranslateW"):with_silent():with_noremap(),
	["v|<S-l>"] = map_cr("TranslateW"):with_silent():with_noremap(),
	-- ["n|<S-s>"] = map_cr("w"):with_noremap():with_silent(),
	["i|<C-l>"] = map_cmd("<right>"):with_noremap():with_silent(),
	["i|<C-h>"] = map_cmd("<left>"):with_noremap():with_silent(),
	["n|<S-w>"] = map_cr("e"):with_noremap():with_silent(),
	-- 调整窗口
	["n|<C-P>"] = map_cu("set wrap"):with_noremap(),

	-- tmux 切换窗口,默认切换窗口方式没覆盖
	-- ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
	-- ["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
	-- ["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
	-- ["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),
	-- tmux 快捷键
	["n|<C-h>"] = map_cr("lua require('tmux').move_left()"):with_silent(),
	["n|<C-l>"] = map_cr("lua require('tmux').move_right()"):with_silent(),
	["n|<C-j>"] = map_cr("lua require('tmux').move_bottom()"):with_silent(),
	["n|<C-k>"] = map_cr("lua require('tmux').move_top()"):with_silent(),
}

local defalte_map = {
	["n|<Tab>"] = map_cr("normal za"):with_noremap():with_silent(),
	["n|<C-x>k"] = map_cr("bdelete"):with_noremap():with_silent(),
	["n|<C-s>"] = map_cu("write"):with_noremap(),
	["n|Y"] = map_cmd("y$"),
	["n|D"] = map_cmd("d$"),
	["n|n"] = map_cmd("nzzzv"):with_noremap(),
	["n|N"] = map_cmd("Nzzzv"):with_noremap(),
	["n|J"] = map_cmd("mzJ`z"):with_noremap(),

	["n|<C-left>"] = map_cmd("<Cmd>vertical resize -3<CR>"),
	["n|<C-right>"] = map_cmd("<Cmd>vertical resize +3<CR>"),
	["n|<C-q>"] = map_cmd("wq<CR>"),
	["n|<A-q>"] = map_cmd("Bwipeout<CR>"),
	["n|<A-S-q>"] = map_cmd("q!<CR>"),
	-- ["n|<C-o>"] = map_cr("setlocal spell! spelllang=en_us"),
	-- Insert
	["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap(),
	["i|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap(),
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>"),
	["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"),
	-- command line
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap(),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap(),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap(),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
	["c|w!!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),
	-- Visual
	["v|<"] = map_cmd("<gv"),
	["v|>"] = map_cmd(">gv"),
}

local load_keymap = function()
	bind.nvim_load_mapping(plug_map)
	bind.nvim_load_mapping(defalte_map)
	bind.nvim_load_mapping(buffer_map)
	bind.nvim_load_mapping(lspsaga_map)
	bind.nvim_load_mapping(git_map)
	bind.nvim_load_mapping(trouble_map)
	bind.nvim_load_mapping(tree_map)
	bind.nvim_load_mapping(telescope_map)
	bind.nvim_load_mapping(dap_map)
end

load_keymap()
