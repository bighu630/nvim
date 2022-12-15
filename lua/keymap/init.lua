local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
require("keymap.config")
vim.g.mapleader = ";"

local plug_map = {
	-- Bufferline
	["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
	["n|gn"] = map_cr("BufferLinePickClose"):with_noremap():with_silent(),
	-- ["n|<Space>cl"] = map_cr("BufferLineCloseLeft"):with_noremap(),
	["n|<C-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent(),
	["n|<C-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent(),
	["n|<C-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent(),
	["n|<C-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent(),
	["n|<C-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent(),
	["n|<C-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent(),
	["n|<S-e>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
	["n|<S-r>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
	-- Packer
	["n|<leader>ps"] = map_cr("PackerSync"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pc"] = map_cr("PackerClean"):with_silent():with_noremap():with_nowait(),
	-- Lsp mapp work when insertenter and lsp start
	["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
	["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
	-- ["n|<F2>"] = map_cr("LSoutlineToggle"):with_noremap():with_silent(),
	["n|="] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent(),
	["n|-"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent(),
	["n|gs"] = map_cr("Lspsaga signature_help"):with_noremap():with_silent(),
	["n|gr"] = map_cr("Lspsaga rename"):with_noremap():with_silent(),
	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
	["n|J"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
	["n|<Space>ll"] = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
	["v|<leader>ca"] = map_cu("Lspsaga code_action"):with_noremap():with_silent(),
	["n|gd"] = map_cr("Lspsaga peek_definition"):with_noremap():with_silent(),
	["n|gD"] = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(),
	["n|gh"] = map_cr("Lspsaga lsp_finder"):with_noremap():with_silent(),
	["n|gps"] = map_cr("G push"):with_noremap():with_silent(),
	["n|gpl"] = map_cr("G pull"):with_noremap():with_silent(),
	-- toggleterm
	-- ["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]), -- switch to normal mode in terminal.
	["n|<C-\\>"] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]]):with_noremap():with_silent(),
	["i|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>"):with_noremap():with_silent(),
	["t|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm<CR>"):with_noremap():with_silent(),
	["n|<C-w>t"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]]):with_noremap():with_silent(),
	["i|<C-w>t"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>"):with_noremap():with_silent(),
	["t|<C-w>t"] = map_cmd("<Esc><Cmd>ToggleTerm<CR>"):with_noremap():with_silent(),
	["n|<F9>"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]]):with_noremap():with_silent(),
	["i|<F9>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>"):with_noremap():with_silent(),
	["t|<F9>"] = map_cmd("<Esc><Cmd>ToggleTerm<CR>"):with_noremap():with_silent(),
	["n|<leader>g"] = map_cr("lua toggle_lazygit()"):with_noremap():with_silent(),
	["t|<leader>g"] = map_cmd("<Esc><Cmd>lua toggle_lazygit()<CR>"):with_noremap():with_silent(),
	["n|<leader>G"] = map_cu("Git"):with_noremap():with_silent(),
	-- Plugin trouble
	["n|gt"] = map_cr("TroubleToggle"):with_noremap():with_silent(),
	["n|<Space>u"] = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent(),
	["n|<leader>cd"] = map_cr("TroubleToggle document_diagnostics"):with_noremap():with_silent(),
	["n|<leader>cw"] = map_cr("TroubleToggle workspace_diagnostics"):with_noremap():with_silent(),
	["n|<leader>cq"] = map_cr("TroubleToggle quickfix"):with_noremap():with_silent(),
	["n|<leader>cl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent(),
	-- Plugin nvim-tree
	["n|ff"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
	["n|<Leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
	["n|<Leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
	-- Plugin Undotree
	["n|<Leader>u"] = map_cr("UndotreeToggle"):with_noremap():with_silent(),
	-- Plugin Telescope
	["n|<Space>p"] = map_cu("lua require('telescope').extensions.project.project{}"):with_noremap():with_silent(),
	["n|<Leader>fr"] = map_cu("lua require('telescope').extensions.frecency.frecency{}"):with_noremap():with_silent(),
	["n|<Space>r"] = map_cu("Telescope oldfiles"):with_noremap():with_silent(),
	["n|<Space>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
	["n|<Leader>sc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent(),
	["n|<Leader>fn"] = map_cu(":enew"):with_noremap():with_silent(),
	["n|<Space>w"] = map_cu("Telescope live_grep"):with_noremap():with_silent(),
	["n|<Leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent(),
	["n|<Leader>fz"] = map_cu("Telescope zoxide list"):with_noremap():with_silent(),
	["n|<Space>hk"] = map_cu("Telescope keymaps"):with_noremap():with_silent(),
	-- Plugin accelerate-jk,加速jk的移动速度
	["n|j"] = map_cmd("v:lua.enhance_jk_move('j')"):with_silent():with_expr(),
	["n|k"] = map_cmd("v:lua.enhance_jk_move('k')"):with_silent():with_expr(),
	-- Plugin vim-eft
	["n|f"] = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
	["n|F"] = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
	["n|t"] = map_cmd("v:lua.enhance_ft_move('t')"):with_expr(),
	-- ["n|T"] = map_cmd("v:lua.enhance_ft_move('T')"):with_expr(),
	-- ["n|;"] = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
	-- Plugin Hop
	-- ["n|<leader>w"] = map_cu("HopWord"):with_noremap(),
	-- ["n|<leader>j"] = map_cu("HopLine"):with_noremap(),
	-- ["n|<leader>k"] = map_cu("HopLine"):with_noremap(),
	-- ["n|<leader>c"] = map_cu("HopChar1"):with_noremap(),
	-- ["n|<leader>cc"] = map_cu("HopChar2"):with_noremap(),
	-- Plugin leap
	["n|s"] = map_cmd([[<Plug>(leap-forward-x)]]):with_silent(),
	["n|<Leader>s"] = map_cmd([[<Plug>(leap-backward-x)]]):with_silent(),

	-- Plugin EasyAlign
	["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
	["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),
	-- Plugin MarkdownPreview
	["n|<F12>"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent(),
	-- Plugin auto_session
	["n|<leader>ss"] = map_cu("SaveSession"):with_noremap():with_silent(),
	["n|<leader>sr"] = map_cu("RestoreSession"):with_noremap():with_silent(),
	["n|<leader>sd"] = map_cu("DeleteSession"):with_noremap():with_silent(),
	-- Plugin SnipRun
	["v|<leader>rf"] = map_cr("SnipRun"):with_noremap():with_silent(),
	["n|<leader>rf"] = map_cr("%SnipRun"):with_noremap():with_silent(),
	-- Plugin dap
	["n|<F5>"] = map_cr("lua require('dap').continue()"):with_noremap():with_silent(),
	["n|<leader>dr"] = map_cr("lua require('dap').continue()"):with_noremap():with_silent(),
	["n|<F4>"] = map_cr("lua require('dap').terminate() require('dapui').close()"):with_noremap():with_silent(),
	["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint();require('modules.editor.dap-util').store_breakpoints(true)")
		:with_noremap()
		:with_silent(),
	["n|<leader>dB"] = map_cr("lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))")
		:with_noremap()
		:with_silent(),
	["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap():with_silent(),
	["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_noremap():with_silent(),
	["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_noremap():with_silent(),
	["n|<F6>"] = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
	["n|<leader>dv"] = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
	["n|<F7>"] = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
	["n|<leader>di"] = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
	["n|<F8>"] = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
	["n|<leader>do"] = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
	["n|<leader>dl"] = map_cr("lua require('dap').repl.open()"):with_noremap():with_silent(),
	["o|m"] = map_cu([[lua require('tsht').nodes()]]):with_silent(),
	["c|Q"] = map_cu([[%SnipRun]]):with_silent(),
	-- Plugin Tabout
	["i|<A-l>"] = map_cmd([[<Plug>(TaboutMulti)]]):with_silent(),
	["i|<A-h>"] = map_cmd([[<Plug>(TaboutBackMulti)]]):with_silent(),
	-- Plugin Diffview
	["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap(),
	["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap(),
	-- My keymap
	["n|<S-q>"] = map_cr("q"):with_silent():with_noremap(),
	["n|<->"] = map_cr("lua vim.diagnostic.goto_next({})"),
	["n|<=>"] = map_cr("lua vim.diagnostic.goto_prev({})"),
	-- Translateor
	["n|<S-t>"] = map_cr("TranslateW"):with_silent():with_noremap(),
	["v|<S-t>"] = map_cr("TranslateW"):with_silent():with_noremap(),

	["n|<S-s>"] = map_cr("w"):with_noremap():with_silent(),
	["i|<C-j>"] = map_cmd("<down>"):with_noremap():with_silent(),
	["i|<C-k>"] = map_cmd("<up>"):with_noremap():with_silent(),
	["i|<C-l>"] = map_cmd("<right>"):with_noremap():with_silent(),
	["i|<C-h>"] = map_cmd("<left>"):with_noremap():with_silent(),
	["n|<S-w>"] = map_cr("e"):with_noremap():with_silent(),
	["n|<F2>"] = map_cr("SymbolsOutline"):with_noremap():with_silent(),
	["n|<C-t>"] = map_cr("transparentToggle"):with_noremap():with_silent(),

	-- 调整窗口
	["n|<C-,"] = map_cu("vertical res -3"):with_noremap(),
	["n|<C-."] = map_cu("vertical res +3"):with_noremap(),
	["n|<C-P>"] = map_cu("set wrap"):with_noremap(),
	-- telescope
}

bind.nvim_load_mapping(plug_map)
